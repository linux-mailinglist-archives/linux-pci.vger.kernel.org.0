Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F3455B06
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 12:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344278AbhKRL7L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 06:59:11 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4104 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344477AbhKRL6E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 06:58:04 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HvyrS44R3z67LGD;
        Thu, 18 Nov 2021 19:54:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 18 Nov 2021 12:55:01 +0100
Received: from localhost (10.52.127.148) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 18 Nov
 2021 11:55:00 +0000
Date:   Thu, 18 Nov 2021 11:54:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Browy <cbrowy@avery-design.com>
CC:     <20210917172205.00000684@huawei.com>, <linux-cxl@vger.kernel.org>,
        "Linux PCI" <linux-pci@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>
Subject: Re: [RFC PATCH 0/4] PCI/CMA and SPDM library
Message-ID: <20211118115457.00002f07@Huawei.com>
In-Reply-To: <6EE76F68-DF21-464E-93CA-47133B540897@avery-design.com>
References: <20210804161839.3492053-1-Jonathan.Cameron@huawei.com>
        <20210805174346.000047f1@huawei.com>
        <20210831135517.0000716f@Huawei.com>
        <6EE76F68-DF21-464E-93CA-47133B540897@avery-design.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.148]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 17 Nov 2021 12:46:48 -0500
Chris Browy <cbrowy@avery-design.com> wrote:

> > On Aug 31, 2021, at 8:55 AM, Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> > 
> > On Thu, 5 Aug 2021 17:43:46 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> >> On Thu, 5 Aug 2021 00:18:35 +0800
> >> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >>   
> >>> This is an RFC to start discussions about how we support the Component
> >>> Measurement and Authentication (CMA) ECN (pcisig.com)
> >>> 
> >>> CMA provides an adaptation of the data objects and underlying protocol
> >>> defined in the DMTF SPDM specification to be used to authenticate and
> >>> conduct run-time measurements of the state of PCI devices (kind of like
> >>> IMA for devices / firmware). This is done using a Data Object Exchange (DOE)
> >>> protocol described in the ECN.
> >>> 
> >>> The CMA ECN is available from the PCI SIG and SPDM can be found at
> >>> https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.1.1.pdf
> >>> 
> >>> CMA/SPDM is focused on establishing trust of the device by:
> >>> 1) Negotiate algorithms supported.
> >>> 2) Retrieve and check the certificate chain from the device against
> >>>   a suitable signing certificate on the host.
> >>> 3) Issue a challenge to the device to verify it can sign with the private
> >>>   key associated with the leaf certificate.
> >>> 4) (Request a measurement of device state)
> >>> 5) (Establish a secure channel for further measurements or other uses)
> >>> 6) (Mutual authentication)
> >>> 
> >>> This RFC only does steps 1-3  
> 
> Could you describe the additional software beyond step 3 that is required to complete 
> the IDE Key Management protocol post SPDM secure session establishment (see PCIe 
> base 6.0r0.9.pdf, Figure 6-59 IDE_KM Example) to reach IDE establishment and run 

Stick to the ECN in references as that is published at least to SIG members.
We shouldn't be discussing draft specs on a public list (though in this case it's the
same material as the published ECN).

> regular applications using IDE streams.  The goal is to do more complete testing of 
> some real CXL devices to the point of running user applications over IDE streams to 
> access HDM memory.

Hi Chris,

This is off the top of my head rather than a considered answer as having a busy week.
Firstly a small thing but IDE requires a different DOE protocol - it is CMA with 
extra stuff but technically different protocol number.
3 a) Add the kernel side messages to actually request a secure channel.
  b) Hook into appropriate kernel subsystems to generate the keys.

After that is up and running (can test by doing some measurements over the now encrypted channel),
then we need to do the key setup as in the IDE spec.  So implement the IDE_KM protocol.
That will cover EPs.  If you have a switch in the path then you'll need to add emulation
support for a DOE on that as well.

Now the host is interesting.  You are allowed but not required to support IDE_KM on a DOE
in the root port (there are lots of other options) or in RCRB.  Also allowed impdef means
which I suspect is going to be more common as a secure channel between components both within
the SoC is a little odd.  That decision may depend on whether a given vendor sees
IDE establishment and maintenance as a firmware / BMC job or an OS one.

IDE_KM protocol has 6 messages and i think we would need to implement them all.

There is also the extended capability to be handled which brings more complexity.
So all the stuff in figure 7-16 IDE_KM Examples (might be the same as the one you refer to...)

We've only gotten as far as mid way down the second block of exchanges.
That diagram assumes host is using an impdef method, but I think we'd be better off
first implementing the RP DOE approach (which will be the same as switch to EP)
and that means negotiating a secure channel etc with the RP as well as the EP.
Then you can program appropriate keys and jump through the various IDE_KM_KSET_GO
as in the diagram.

There is quite a lot of work to be done to bring up the full flow, but, interestingly I think
there will be far fewer open questions in that part of enablement than we have for
earlier steps of SPDM setup, simply because it doesn't really interact with the
rest of Linux so sits almost entirely in the PCI subsystem.  A fun early question is
how we decide it needs to be enabled at all.

Whilst I'm planning to eventually get this all in place it may take a while.

If we were making a plan...
1) Finish of SPDM stuff - so secure channel setup and ideally flesh out measurements for which
   I have a prototype.
2) Qemu emulation RP with IDE support (building on your team's work on EP support).
3) Bring up basic flow against that emulation.
4) Figure out what to do about key refresh...
5) Qemu emulation of switch.
6) Bring flows up against switch etc.
7) Selective IDE.
8) P2P selective IDE...
9) Retire and let the youngsters actually use it ;)

Jonathan


> 
> >>> 
> >>> Testing of this patch set has been conducted against QEMU emulation of
> >>> the device backed by openSPDM emulation of the SPDM protocol.    
> >> 
> >> Note testing also works with libspdm and libspdm-emu from
> >> https://github.com/DMTF/spdm-emu with no modifications.
> >> 
> >> The openSPDM modifications Chris and team made were all associated with the host
> >> end and are not needed for this code (the QEMU part is still needed to provide
> >> the DOE emulation and forward the traffic to spdm_responder_emu)
> >> 
> >> I should also have mentioned this series is on top of the recently posted
> >> DOE series rebased onto the linux-cxl next git tree.  I'm not really expecting
> >> anyone to test it at this stage, but if desired I can push a full tree out
> >> somewhere with this in place.  
> > 
> > A couple of updates:
> > 
> > 1. This topic is on the agenda for the linaro-open-discussions call tomorrow.
> > https://linaro.atlassian.net/wiki/spaces/LOD/overview
> > It's a public call and anyone interested is welcome to join in. Time is rather
> > unfriendly for US based people unfortunately. I'll throw together some sort of
> > overview / open questions slide deck which will be posted on that page. Note
> > related topics on plumbers microconf agenda later in the month - I'll share details
> > of that once known.
> > 
> > 2. Related to that I had a request for trees as the base of the various series are not
> > obvious (involved a bunch of rebases of various other patch sets)
> > 
> > https://github.com/hisilicon/kernel-dev/tree/doe-spdm-v1 rebased to 5.14-rc7
> > https://github.com/hisilicon/qemu/tree/cxl-hacks rebased to qemu/master as of Friday
> > 
> > For qemu side of things you need to be running spdm_responder_emu --trans PCI_DOE 
> > from https://github.com/DMTF/spdm-emu first (that will act as server to qemu acting
> > as a client). Various parameters allow you to change the algorithms advertised and the
> > kernel code should work for all the ones CMA mandates (but nothing beyond that for now).
> > 
> > For the cxl device the snippet of qemu commandline needed is:
> > -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-mem1, id=cxl-pmem0,size=2G,spdm=true
> > 
> > Otherwise much the same as https://people.kernel.org/jic23/ (instructions written to enable
> > testing of the DOE patches this built on).
> > 
> > Build at least the cxl_pci driver as a module as we need to poke the certificate into the keychain
> > before that (find the cert in spdm_emu tree).
> > Instructions to do that with keyctl and evmctl are in the cover letter of the patch series.
> > 
> > Hopefully I'll find some time soonish to update that blog post with instructions.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >> 
> >> Jonathan
> >>   
> >>> 
> >>> https://lore.kernel.org/qemu-devel/1624665723-5169-1-git-send-email-cbrowy@avery-design.com/
> >>> 
> >>> Open questions are called out in the individual patches but the big ones are
> >>> probably:
> >>> 
> >>> 1) Certificate management.
> >>>   Current code uses a _cma keyring created by the kernel, into which a
> >>>   suitable root certificate can be inserted from userspace.
> >>> 
> >>>   A=$(keyctl search %:_cma  keyring _cma)
> >>>   evmctl import ecdsaca.cert.der $A
> >>> 
> >>>   Is this an acceptable way to load the root certificates for this purpose?
> >>> 
> >>>   The root of the device provided certificate chain is then checked against
> >>>   certificates on this keychain, but is itself (with the other certificates
> >>>   in the chain) loaded into an SPDM instance specific keychain.  Currently
> >>>   there is no safe cleanup of this which will need to be fixed.
> >>> 
> >>>   Using the keychain mechanism provides a very convenient way to manage these
> >>>   certificates and to allow userspace to read them for debug purpose etc, but
> >>>   is this the right use model?
> >>> 
> >>>   Finally the leaf certificate of this chain is used to check signatures of
> >>>   the rest of the communications with the device.
> >>> 
> >>> 2) ASNL1 encoder for ECDSA signature
> >>>   It seems from the openSPDM implementation that for these signatures,
> >>>   the format is a simple pair of raw values.  The kernel implementation of
> >>>   ECDSA signature verification assumes ASN1 encoding as seems to be used
> >>>   in x509 certificates.  Currently I work around that by encoding the
> >>>   signatures so that the ECDSA code can un-encode them again and use them.
> >>>   This seems slightly silly, but it is minimum impact on current code.
> >>>   Other suggestions welcome.
> >>> 
> >>> 3) Interface to present to drivers. Currently I'm providing just one exposed
> >>>   function that wraps up all the exhanges until a challenge authentication
> >>>   response from the device. This is done using one possible sequence.
> >>>   I don't think it makes sense to expose the low level components due to the
> >>>   underlying spdm_state updates and there only being a fixed set of valid
> >>>   orderings.
> >>> 
> >>> Future patches will raise questions around management of the measurements, but
> >>> I'll leave those until I have some sort of implementation to shoot at.
> >>> The 'on probe' use in the CXL driver is only one likely time when authentication
> >>> would be needed.
> >>> 
> >>> Note I'm new to a bunch of the areas of the kernel this touches, so have
> >>> probably done things that are totally wrong.
> >>> 
> >>> CC list is best effort to identify those who 'might' care.  Please share
> >>> with anyone I've missed.
> >>> 
> >>> Thanks,
> >>> 
> >>> Jonathan
> >>> 
> >>> 
> >>> Jonathan Cameron (4):
> >>>  lib/asn1_encoder: Add a function to encode many byte integer values.
> >>>  spdm: Introduce a library for DMTF SPDM
> >>>  PCI/CMA: Initial support for Component Measurement and Authentication
> >>>    ECN
> >>>  cxl/pci: Add really basic CMA authentication support.
> >>> 
> >>> drivers/cxl/Kconfig          |    1 +
> >>> drivers/cxl/mem.h            |    2 +
> >>> drivers/cxl/pci.c            |   13 +-
> >>> drivers/pci/Kconfig          |    9 +
> >>> drivers/pci/Makefile         |    1 +
> >>> drivers/pci/doe.c            |    2 -
> >>> include/linux/asn1_encoder.h |    3 +
> >>> include/linux/pci-doe.h      |    2 +
> >>> lib/Kconfig                  |    3 +
> >>> lib/Makefile                 |    2 +
> >>> lib/asn1_encoder.c           |   54 ++
> >>> lib/spdm.c                   | 1196 ++++++++++++++++++++++++++++++++++
> >>> 12 files changed, 1285 insertions(+), 3 deletions(-)
> >>> create mode 100644 lib/spdm.c
> >>>   
> >>   
> >   
> 

