Return-Path: <linux-pci+bounces-11196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD709461E6
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 18:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BB5282374
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF01516BE11;
	Fri,  2 Aug 2024 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8tiPVO8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378A16BE02;
	Fri,  2 Aug 2024 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722616906; cv=none; b=Vhgdm+ngvtnDaXeSF9OaSA8T0fkFUwYtVXB+Y1jOmS9kD8qygxXS8za4FYplV+sOGsXElohlTZdhwTPXI9O0BKODucasWYkxcM6aK8mPUSorWgBS/TCFe6uDfgiYgBsxcFO4HXLYlC94dnmJzqhNccomSstPDvw8Vd5StnP9ak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722616906; c=relaxed/simple;
	bh=u8PgrutsRG1IBN6ocrR8XBsZqyyOLj5JqQ4VTfukrSM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LjMgfh/HZpegrcsfyEkisDnhldTC5Mkdepry6pBrPzf8xz4ks223upblcknSuFJn/BkuNCn5FJ5hfM3ZvhChxf1/uga80y0/fD1V3VWZkWW6AyBP+UOp6VkjFthlgtc3ezyZlPEaoCK6bOiCS5lRLloi5jLhDqGi2dvbyGMlRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8tiPVO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEC1C32782;
	Fri,  2 Aug 2024 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722616905;
	bh=u8PgrutsRG1IBN6ocrR8XBsZqyyOLj5JqQ4VTfukrSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r8tiPVO8vdMUokOLtVWTqvXh5HpE6K8s5h2z+TtmBb2zl27XeKP5iprxLWS4TTVqj
	 0OI3L++4XvzfbO5zrmrOJwUr9mBgbUXv2LO4ko4n9jm7RvwMdhM2EENxRaoirnpcHY
	 mw5lgC0xaOGd6gWyILSNVea3B1rig0BgYIVMnaYNO1CB2lthnZAyQ7Aw9zIz/8jaE5
	 4eShQGFookFi/AsdDYjhDd0VjWGUL96WCSevh0XQeCW/obk0k7OO7g7nhS+rqogJca
	 RrPq+DoJw0fyxmDB8JXM5lOxD4wA4GWvhGSe5LrXPUiZbpjOQmJ10dmB8MBEjhvI3H
	 S5bbShNqDLtYw==
Date: Fri, 2 Aug 2024 11:41:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: ngn <ngn@ngn.tf>
Cc: Nam Cao <namcao@linutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: shpchp: Remove hpc_ops
Message-ID: <20240802164143.GA153790@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqzZwRx0Fug4bcwv@archbtw>

On Fri, Aug 02, 2024 at 04:06:09PM +0300, ngn wrote:
> On Thu, Aug 01, 2024 at 07:08:52PM -0500, Bjorn Helgaas wrote:
> > On Tue, Jul 23, 2024 at 02:43:25PM +0300, ngn wrote:
> > > Remove the hpc_ops struct from shpchp. This struct is unnecessary as
> > > no other hotplug controller implements it. A similar thing has already
> > > been done in pciehp with commit 82a9e79ef132 ("PCI: pciehp: remove hpc_ops")
> > 
> > > +++ b/drivers/pci/hotplug/shpchp_hpc.c
> > > @@ -167,7 +167,6 @@
> > >  
> > >  static irqreturn_t shpc_isr(int irq, void *dev_id);
> > >  static void start_int_poll_timer(struct controller *ctrl, int sec);
> > > -static int hpc_check_cmd_status(struct controller *ctrl);
> > >  
> > >  static inline u8 shpc_readb(struct controller *ctrl, int reg)
> > >  {
> > > @@ -317,7 +316,7 @@ static int shpc_write_cmd(struct slot *slot, u8 t_slot, u8 cmd)
> > >  	if (retval)
> > >  		goto out;
> > >  
> > > -	cmd_status = hpc_check_cmd_status(slot->ctrl);
> > > +	cmd_status = shpchp_check_cmd_status(slot->ctrl);
> > 
> > This rename looks like it should be a separate patch because it's not
> > part of removing hpc_ops.
> 
> I think hpc_check_cmd_status meant to be a part of the hpc_ops struct.
> Here is the original struct:
> 
> struct hpc_ops {
> 	int (*power_on_slot)(struct slot *slot);
> 	int (*slot_enable)(struct slot *slot);
> 	int (*slot_disable)(struct slot *slot);
> 	int (*set_bus_speed_mode)(struct slot *slot, enum pci_bus_speed speed);
> 	int (*get_power_status)(struct slot *slot, u8 *status);
> 	int (*get_attention_status)(struct slot *slot, u8 *status);
> 	int (*set_attention_status)(struct slot *slot, u8 status);
> 	int (*get_latch_status)(struct slot *slot, u8 *status);
> 	int (*get_adapter_status)(struct slot *slot, u8 *status);
> 	int (*get_adapter_speed)(struct slot *slot, enum pci_bus_speed *speed);
> 	int (*get_prog_int)(struct slot *slot, u8 *prog_int);
> 	int (*query_power_fault)(struct slot *slot);
> 	void (*green_led_on)(struct slot *slot);
> 	void (*green_led_off)(struct slot *slot);
> 	void (*green_led_blink)(struct slot *slot);
> 	void (*release_ctlr)(struct controller *ctrl);
> 	int (*check_cmd_status)(struct controller *ctrl);
> };
> 
> As you can see it contains a pointer for check_cmd_status function,
> however the hpc_check_cmd_status was never assigned to it:
> 
> static const struct hpc_ops shpchp_hpc_ops = {
> 	.power_on_slot			= hpc_power_on_slot,
> 	.slot_enable			= hpc_slot_enable,
> 	.slot_disable			= hpc_slot_disable,
> 	.set_bus_speed_mode		= hpc_set_bus_speed_mode,
> 	.set_attention_status	= hpc_set_attention_status,
> 	.get_power_status		= hpc_get_power_status,
> 	.get_attention_status	= hpc_get_attention_status,
> 	.get_latch_status		= hpc_get_latch_status,
> 	.get_adapter_status		= hpc_get_adapter_status,
> 
> 	.get_adapter_speed		= hpc_get_adapter_speed,
> 	.get_prog_int			= hpc_get_prog_int,
> 
> 	.query_power_fault		= hpc_query_power_fault,
> 	.green_led_on			= hpc_set_green_led_on,
> 	.green_led_off			= hpc_set_green_led_off,
> 	.green_led_blink		= hpc_set_green_led_blink,
> 
> 	.release_ctlr			= hpc_release_ctlr,
> };
> 
> Which made me believe that this function supposed to be a part of the
> hpc_ops struct and whoever wrote the code added a pointer for it but
> then they forgot to assign the function to it during the actual
> definition of the struct. So I renamed it anyway.

Good point, thanks.  Applied to pci/hotplug for v6.12, thanks for your
work!

Bjorn

