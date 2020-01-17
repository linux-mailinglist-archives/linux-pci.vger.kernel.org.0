Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB22141443
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 23:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgAQWrh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 17:47:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57883 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgAQWrh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jan 2020 17:47:37 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1isaOn-0001C8-UQ; Fri, 17 Jan 2020 23:47:30 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id DAB00100C19; Fri, 17 Jan 2020 23:47:28 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     hkallweit1@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        maz@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: MSI irqchip configured as IRQCHIP_ONESHOT_SAFE causes spurious IRQs
In-Reply-To: <CAGi-RUJTGMA2VuhxA--0hvYgEPJydBPT9uHXD2YBToKgf3Zmbg@mail.gmail.com>
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com> <87wo9ub5f6.fsf@nanos.tec.linutronix.de> <CAGi-RUK_TA+WWvXJSrsa=_Pwq0pV1ffUKOCBu5c1t8O5Xs+UJg@mail.gmail.com> <CAGi-RUJG=SB7az5FFVTzzgefn_VXUbyQX1dtBN+9gkR7MgyC6g@mail.gmail.com> <87imldbqe3.fsf@nanos.tec.linutronix.de> <CAGi-RULNwpiNGYALYRG84SOUzkvNTbgctmXoS=Luh29xDHJzYw@mail.gmail.com> <87v9pcw55q.fsf@nanos.tec.linutronix.de> <CAGi-RUJPJ59AMZp3Wap=9zSWLmQSXVDtkbD+O6Hofizf8JWyRg@mail.gmail.com> <87pnfjwxtx.fsf@nanos.tec.linutronix.de> <CAGi-RUJtqdLtFBVMxL8TOQ3LGRqqrV4Ge7Fu9mTyDoQVYxtA5g@mail.gmail.com> <87zhem172r.fsf@nanos.tec.linutronix.de> <CAGi-RUJkr0gPbynYe+Gkk-JoeyCHdSvd9zdgCv4Hij5vfGVMEA@mail.gmail.com> <87sgke1004.fsf@nanos.tec.linutronix.de> <CAGi-RUJTGMA2VuhxA--0hvYgEPJydBPT9uHXD2YBToKgf3Zmbg@mail.gmail.com>
Date:   Fri, 17 Jan 2020 23:47:28 +0100
Message-ID: <87lfq54s5b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ramon,

Ramon Fried <rfried.dev@gmail.com> writes:
> On Fri, Jan 17, 2020 at 7:11 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> The device which incorporates the MSI endpoint.
>
> This is not how the MSI specs describe it, so I'm confused.
> According to spec, MSI is just an ordinary post PCIe TLP to a certain
> memory on the root-complex.

That's the message transport itself.

> The only information it has whether to send an MSI or not is the
> masked/pending register in the config space.

Correct.

> So, basically, back to my original question, without tinkering with
> these bits, the device will always send the MSI's,

What do you mean with 'always send'?

It will send ONE message every time the device IP block raises an
interrupt as long as it's not masked in the config space.

> it's just that they will be masked on the MSI controller on the
> host. right ?

No. If you mask them on the host then you can lose interupts.

Lets take an example. Network card.

   Incoming packet
   network controller raises interrupt
   MSI endpoint sends message
   Message raises interrupt in CPU

   interrupt is serviced
      handle_edge_irq()
        acknowledge interrupt at the CPU level
        call_driver_interrupt_handler()
           fiddle_with_device()
   return from interrupt

So now if you use a threaded handler in that driver (or use force
threading) then this looks so:

   Incoming packet
   network controller raises interrupt
   MSI endpoint sends message
   Message raises interrupt in CPU

   interrupt is serviced
      handle_edge_irq()
      acknowledge interrupt at the CPU level
      call_primary_interrupt_handler()
          wake_irq_thread()
  return from interrupt

  run_irq_thread()
      call_driver_interrupt_handler()
        fiddle_with_device()
      wait_for_next_irq();

In both cases the network controller can raise another interrupt
_before_ the intial one has been fully handled and of course the MSI
endpoint will send a new message which triggers the pending logic in the
edge handler or in case of a threaded handler kicks the thread to run
another round.

Now you might think that if there are tons of incoming packets then the
network controller will raise tons of interrupts before the interrupt
handler completes. That would be outright stupid. So what the network
controller (assumed it is sanely designed) does is:

  packet arrives
  if (!raised_marker) {
     raise_interrupt;
     set raised_marker;
  }   

So now the interrupt handler comes around to talk to the device and the
processing clears the raised_marker at some point. Either by software or
automatically when the queue is empty.

If you translate that into a electrical diagram:

Packet    1    2      3        4

            ________     _____   _ 
NetC-Int  _|        |___|     |_| |_____

MSI-EP     M            M       M          M = Message

CPU INT     |            |       |

Driver        _______      _________
handler  ____|       |____|         |______

If you look at packet #4 then you notice that the interrupt for this
packet is raised and the message is sent _before_ the handler finishes.

And that's where we need to look at interrupt masking.

1) Masking at the MSI endpoint (PCI configspace)

   This is slow and depending on the PCI host this might require
   to take global locks, which is even worse if you have multi queue
   devices firing all at the same time.

   So, no this is horrible and it's also not required.

2) Masking at the host interrupt controller

   Depending on the implementation of the controller masking can cause
   interrupt loss. In the above case the message for packet #4 could
   be dropped by the controller. And yes, there are interrupt
   controllers out there which have exactly this problem.

   That's why the edge handler does not mask the interrupt in the first
   place.

So now you can claim that your MSI host controller does not have that
problem. Fine, then you could do masking at the host controller level,
but what does that buy you? Lets look at the picture again:

Packet    1    2      3        4

            ________     _____   ____
NetC-Int  _|        |___|     |_|    |__

MSI-EP     M            M       M             M = Message

CPU INT     |            |         |
Driver       _________    ________   __
handler  ____M       U____M       U_M  U____  M = Mask, U = Unmask

You unmask just to get the next interrupt so you mask/handle/unmask
again. That's actually slower because you get the overhead of unmask,
which raises the next interrupt in the CPU (it's already latched in the
MSI translator) and then yet another mask/unmask pair.  No matter what,
you'll lose.

And if you take a look at network drivers, then you find quite some of
them which do only one thing in their interrupt service routine:

     napi_schedule();

That's raising the NAPI softirq and nothing else. They touch not even
the device at all and delegate all the processing to softirq
context. They rely on the sanity of the network controller not to send
gazillions of interrupts before the pending stuff has been handled.

That's not any different than interrupt threading. It's exactly the same
except that the handling runs in softirq context and not in an dedicated
interrupt thread.

So if you observe issues with your PCI device that it sends gazillions
of interrupts before the pending ones are handled, then you might talk
to the people who created that beast or you need to do what some of the
network controllers do:

  hard_interrupt_handler()
    tell_device_to_shutup();
    napi_schedule();

and then something in the NAPI handling tells the device that it can
send interrupts again.

You can do exactly the same thing with interrupt threading. Register a
primary handler and a threaded handler and let the primary handler do:

  hard_interrupt_handler()
    tell_device_to_shutup();
    return IRQ_WAKE_THREAD;

Coming back to your mask/unmask thing. That has another downside which
is layering violation and software complexity.

MSI interrupts are edge type by specification:

  "MSI and MSI-X are edge-triggered interrupt mechanisms; neither the
   PCI Local Bus Specification nor this specification support
   level-triggered MSI/MSI-X interrupts."

The whole point of edge-triggered interrupts is that they are just a
momentary notification which means that they can avoid the whole
mask/unmask dance and other issues. There are some limitations to edge
type interrupts:

  - Cannot be shared, which is a good thing. Shared interrupts are
    a pain in all aspects

  - Can be lost if the momentary notification does not reach the
    receiver. For actual electrical edge type interrupts this happens
    when the active state is too short so that the edge detection
    on the receiver side fails to detect it.

    For MSI this is usually not a problem. If the message gets lost on
    the bus then you have other worries than the lost interrupt.

    But for both electrical and message based the interrupt receiver on
    the host/CPU side can be a problem when masking is in play. There
    are quite some broken controllers out there which have that issue
    and it's not trivial to get it right especially with message based
    interrupts due to the async nature of the involved parts.

That's one thing, but now lets look at the layering.

Your MSI host side IP is not an interrupt controller. It is a bridge
which translates incoming MSI messages and multiplexes them to a level
interrupt on the GIC. It provides a status register which allows you to
demultiplex the pending interrupts so you don't have to poll all
registered handlers to figure out which device actually fired an
interrupt. Additionally it allows masking, but that's an implementation
detail and you really should just ignore it except for startup/shutdown.

From the kernels interrupt system POV the MSI host side controller is
just a bridge between MSI and GIC.

That's clearly reflected in the irq hierarchy:

|-------------|
|             |
| GIC         |
|             |
|-------------|

|-------------|         |----------|
|             |         |          |
| MSI bridge  |---------| PCI/MSI  |
|             |         |          |
|-------------|         |----------|

The GIC and the MSI bridge are independent components. The fact that the
MSI bridge has an interrupt output which is connected to the GIC does
not create an hierarchy. From the GIC point of view the MSI bridge is
just like any other peripheral which is connected to one of its input
lines.

But the PCI/MSI domain has a hierarchical parent, the MSI Bridge. The
reason why this relationship exists is that the PCI/MSI domain needs a
way to allocate a message/address for interrupt delivery. And that
information is provided by the MSI bridge domain.

In an interrupt hierarchy the type of the interrupt (edge/level) and the
required handler is determined by the outmost domain, in this case the
PCI/MSI domain. This domain mandates edge type and the edge handler.

And that outermost domain is the primary interrupt chip which is
involved when the core code manages and handles interrupts. So
mask/unmask happens at the pci_msi interrupt chip which fiddles with the
MSI config space. The outermost device can call down into the hierarchy
to let the underlying domain take further action or delegate certain
actions completely to the underlying domain, but that delegation is
pretty much restricted. One example for delegation is the irq_ack()
action. The ack has to hit the underlying domain usually as on the MSI
endpoint there is no such thing. If the underlying domain does not need
that then the irq_ack() routine in the underlying domain is just empty
or not implemented. But you cannot delegate mask/unmask and other
fundamental actions because they must happen on the MSI endpoint no
matter what.

You cannot create some artifical level semantics on the PCI/MSI side and
you cannot artificially connect your demultiplexing handler to the
threaded handler of the PCI interrupt without violating all basic rules
of engineering and common sense at once.

Let me show you the picture from above expanded with your situation:

Packet    1    2      3        4

            ________     _____   _ 
NetC-Int  _|        |___|     |_| |_____

MSI-EP     M            M       M               M = Message

             _            _      _
Bridge    __| |__________| |____| |_______

             _            _      _
GIC input __| |__________| |____| |_______

CPU INT     |            |       |

Demux         _            _      _
handler    __A |__________A |____A |_______     A == Acknowledge in the bridge

Thread         _______      _________
handler   ____|       |____|         |______

Hope that helps and clarifies it.

Thanks,

        tglx
