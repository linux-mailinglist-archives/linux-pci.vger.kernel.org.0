Return-Path: <linux-pci+bounces-11191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4510945E6B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 15:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8221C21524
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 13:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6871DAC5F;
	Fri,  2 Aug 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ngn.tf header.i=@ngn.tf header.b="LrTGrjyY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.ngn.tf (ngn.tf [193.106.196.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA421E3CC3;
	Fri,  2 Aug 2024 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.106.196.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722604404; cv=none; b=IrYi39nfZJ5p/mUoYEqTgFXV1duBv5WVeQ0e0HHYn7h9IWx9z1122/eVqVO5mJswtk4GIC2Nic2oVQSNQgH+Lwc8ZkHHzbcXV3ivj+TZC+xYDc2n6hTh25a8sIcgIUR+u18BeOWUPCoGkee+68w9p6+foUzuCh4BF8lWr3Blm+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722604404; c=relaxed/simple;
	bh=3UFpgyCFVFFSP7w9ZXE06UkaNdzc2jHhYbdzI1pJgQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkV0dmzQjzZn3ZzIQpJ7M0+kK75fYLY/gDAIPf0Q1ym4DN5vkDmjn/XmFdRUFSN8ez//PZ9m3KuJtS9QwJpbnCcuP/AR5XekJQwHRZeuQXzegUrOr6sGEQ/2BOCcQ/22OX0XYIWzPR8wMKRbHix7wZe9mZSJ9ZLXx9pdYZtarQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ngn.tf; spf=pass smtp.mailfrom=ngn.tf; dkim=pass (2048-bit key) header.d=ngn.tf header.i=@ngn.tf header.b=LrTGrjyY; arc=none smtp.client-ip=193.106.196.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ngn.tf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ngn.tf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ngn.tf; s=mail;
	t=1722604043; bh=3UFpgyCFVFFSP7w9ZXE06UkaNdzc2jHhYbdzI1pJgQs=;
	h=From:To:Cc:Subject:References:In-Reply-To;
	b=LrTGrjyYMCVWcXl95+FEVuYzzUu89hkK5NJ+BKjq0DtQq0fNGUjGekHQi5Q4QNCK/
	 oan5fylRvA95e0gV4GsGHJse+lQE1p3+s23sn5V5ZuZMUQbW+fJ1nVdDg+/GN7smR1
	 HzDZx0Qc3KCsq2tcEcZOB86C53Yjjos2hZx645nXr4oORTJwtubvpaP1Iepigm15fJ
	 HZdgrcj7161B3LMgtWWUcQZQkNhY+DFOoEmTx32AjKxD/Q3O5NrYGzpZNXYhcgB/NP
	 sHHJkxbZcI8xna015/ItpOhQ2Qqd6zjTY6Dh+WAx4BgOJjRJLOluFxMwq2HG/rQyTn
	 OdNE2OXLR0qGQ==
Date: Fri, 2 Aug 2024 16:06:09 +0300
From: ngn <ngn@ngn.tf>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: shpchp: Remove hpc_ops
Message-ID: <ZqzZwRx0Fug4bcwv@archbtw>
References: <Zp-XXVW4hlcMASEc@archbtw>
 <20240802000852.GA129961@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802000852.GA129961@bhelgaas>

On Thu, Aug 01, 2024 at 07:08:52PM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 23, 2024 at 02:43:25PM +0300, ngn wrote:
> > Remove the hpc_ops struct from shpchp. This struct is unnecessary as
> > no other hotplug controller implements it. A similar thing has already
> > been done in pciehp with commit 82a9e79ef132 ("PCI: pciehp: remove hpc_ops")
> 
> > +++ b/drivers/pci/hotplug/shpchp_hpc.c
> > @@ -167,7 +167,6 @@
> >  
> >  static irqreturn_t shpc_isr(int irq, void *dev_id);
> >  static void start_int_poll_timer(struct controller *ctrl, int sec);
> > -static int hpc_check_cmd_status(struct controller *ctrl);
> >  
> >  static inline u8 shpc_readb(struct controller *ctrl, int reg)
> >  {
> > @@ -317,7 +316,7 @@ static int shpc_write_cmd(struct slot *slot, u8 t_slot, u8 cmd)
> >  	if (retval)
> >  		goto out;
> >  
> > -	cmd_status = hpc_check_cmd_status(slot->ctrl);
> > +	cmd_status = shpchp_check_cmd_status(slot->ctrl);
> 
> This rename looks like it should be a separate patch because it's not
> part of removing hpc_ops.

I think hpc_check_cmd_status meant to be a part of the hpc_ops struct.
Here is the original struct:

struct hpc_ops {
	int (*power_on_slot)(struct slot *slot);
	int (*slot_enable)(struct slot *slot);
	int (*slot_disable)(struct slot *slot);
	int (*set_bus_speed_mode)(struct slot *slot, enum pci_bus_speed speed);
	int (*get_power_status)(struct slot *slot, u8 *status);
	int (*get_attention_status)(struct slot *slot, u8 *status);
	int (*set_attention_status)(struct slot *slot, u8 status);
	int (*get_latch_status)(struct slot *slot, u8 *status);
	int (*get_adapter_status)(struct slot *slot, u8 *status);
	int (*get_adapter_speed)(struct slot *slot, enum pci_bus_speed *speed);
	int (*get_prog_int)(struct slot *slot, u8 *prog_int);
	int (*query_power_fault)(struct slot *slot);
	void (*green_led_on)(struct slot *slot);
	void (*green_led_off)(struct slot *slot);
	void (*green_led_blink)(struct slot *slot);
	void (*release_ctlr)(struct controller *ctrl);
	int (*check_cmd_status)(struct controller *ctrl);
};

As you can see it contains a pointer for check_cmd_status function,
however the hpc_check_cmd_status was never assigned to it:

static const struct hpc_ops shpchp_hpc_ops = {
	.power_on_slot			= hpc_power_on_slot,
	.slot_enable			= hpc_slot_enable,
	.slot_disable			= hpc_slot_disable,
	.set_bus_speed_mode		= hpc_set_bus_speed_mode,
	.set_attention_status	= hpc_set_attention_status,
	.get_power_status		= hpc_get_power_status,
	.get_attention_status	= hpc_get_attention_status,
	.get_latch_status		= hpc_get_latch_status,
	.get_adapter_status		= hpc_get_adapter_status,

	.get_adapter_speed		= hpc_get_adapter_speed,
	.get_prog_int			= hpc_get_prog_int,

	.query_power_fault		= hpc_query_power_fault,
	.green_led_on			= hpc_set_green_led_on,
	.green_led_off			= hpc_set_green_led_off,
	.green_led_blink		= hpc_set_green_led_blink,

	.release_ctlr			= hpc_release_ctlr,
};

Which made me believe that this function supposed to be a part of the
hpc_ops struct and whoever wrote the code added a pointer for it but
then they forgot to assign the function to it during the actual
definition of the struct. So I renamed it anyway.

