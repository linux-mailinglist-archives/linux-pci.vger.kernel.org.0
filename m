Return-Path: <linux-pci+bounces-1584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0318214E4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 19:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D591C20D3D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AEFBA3A;
	Mon,  1 Jan 2024 18:11:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E79464;
	Mon,  1 Jan 2024 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id B644B300002C4;
	Mon,  1 Jan 2024 19:11:46 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9770D4E76C; Mon,  1 Jan 2024 19:11:46 +0100 (CET)
Date: Mon, 1 Jan 2024 19:11:46 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 07/10] PCI/LINK: Re-add BW notification portdrv as
 PCIe BW controller
Message-ID: <20240101181146.GA26390@wunner.de>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
 <20230929115723.7864-8-ilpo.jarvinen@linux.intel.com>
 <20231230155810.GB25718@wunner.de>
 <ada759ad-c2e-41d7-e15f-a7a3dc208771@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ada759ad-c2e-41d7-e15f-a7a3dc208771@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jan 01, 2024 at 07:37:25PM +0200, Ilpo Järvinen wrote:
> On Sat, 30 Dec 2023, Lukas Wunner wrote:
> > On Fri, Sep 29, 2023 at 02:57:20PM +0300, Ilpo Järvinen wrote:
> > > +	pcie_capability_write_word(dev, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
> > > +	pcie_capability_set_word(dev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LBMIE);
> > 
> > I'm wondering why we're not enabling LABIE as well?
> > (And clear LABS.)
> > 
> > Can't it happen that we miss bandwidth changes unless we enable that
> > as well?
> 
> Thanks. Reading the spec, it sounds like both are necessary to not miss 
> changes.

I guess this is an artefact of Alex' original patch.
I don't know why he enabled one but not the other.


> > > +	ret = request_irq(srv->irq, pcie_bw_notification_irq,
> > > +			  IRQF_SHARED, "PCIe BW ctrl", srv);
> > 
> > Is there a reason to run the IRQ handler in hardirq context
> > or would it work to run it in an IRQ thread?  Usually on systems
> > than enable PREEMPT_RT, a threaded IRQ handler is preferred,
> > so unless hardirq context is necessary, I'd recommend using
> > an IRQ thread.
> 
> Can I somehow postpone the decision between IRQ_NONE / IRQ_HANDLED
> straight into the thread_fn? One LNKSTA read is necessary to decide 
> that.
> 
> I suppose the other write + reread of LNKSTA could be moved into
> thread_fn even if the first read would not be movable.

You can just use request_threaded_irq(), pass NULL for the "handler"
argument and pcie_bw_notification_irq for the "thread_fn" argument.

Because of the NULL argument for "handler", the hardirq handler will
then become irq_default_primary_handler().  Which does nothing else
but return IRQ_WAKE_THREAD.  And the decision between IRQ_NONE and
IRQ_HANDLED is then indeed postponed to the IRQ thread.

Alternatively you can split the IRQ handler, move the check whether
PCI_EXP_LNKSTA_LBMS is set to the hardirq handler and keep the rest
in the IRQ thread.  Means you won't have unnecessary wakeups of the
IRQ thread if the interrupt is caused by something else (I understand
it's always shared with PME and hotplug).  But you'll spend more time
in hardirq context.  In practice bandwidth notifications may be more
frequent than PME and hotplug interrupts, so unnecessary wakeups of
the IRQ thread will be rare.  Hence not splitting the IRQ handler
may be better.  Dunno.  Ask Thomas Gleixner or Sebastian Siewior. :)

Thanks,

Lukas

