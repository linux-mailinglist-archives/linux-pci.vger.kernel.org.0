Return-Path: <linux-pci+bounces-11151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5411C945522
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 02:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117A7284B0C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 00:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD167F6;
	Fri,  2 Aug 2024 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmfxvsRn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C517523A9;
	Fri,  2 Aug 2024 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557334; cv=none; b=UYxb/SfPvWjcsuIY/4AoNyc8WWzZ6ePoxpoglRxv1bH/WcXIBB5MUxKvEVSg0HICExovHkf6hZXlKBFLuqvENmDv6LISBLAzrCP+wipoGhuiUJIaMq8HVmI80uTuC19MCokQg9Xh6cFUv1ZArNY/j53oAscGzR0CJtKIfXUBPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557334; c=relaxed/simple;
	bh=5tdJs5WYDV0HVlhLuKkkaqSNGsFGgCcgia087+xWSos=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RV3JMjHHg1xKSs0Tr3NSGcD0jf6Ueg6Rii57OTsqr+Se9rclK9NIy4tXu17oV5EHXeQAYV0gDrWo7V9dDvza1x/NP5exqAeqfhnzVEigDJoPoxq6eBbIhDYQBOcxX5m6mOSCW3CE46VhohR4q3u05Jvt1RHj/Jxag7EDC4KP3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmfxvsRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E167C32786;
	Fri,  2 Aug 2024 00:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722557334;
	bh=5tdJs5WYDV0HVlhLuKkkaqSNGsFGgCcgia087+xWSos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YmfxvsRne07ASnM9qemG0OUJV/t4II51X4kNTZ5AV0OEJY3sHaiG3sPt7hLRnFyuU
	 7Q3wUBzdnePjS1+nNreswsdjKn6HGOTtII7pOsi65J/ZTTZBiFeTszYS0nWLm3JMbY
	 Q4l8tR13ggUFzQPbf7PHW8k9NetzpnTqndBjqLG8rVNXVKjbHEOuIsMaNZSjdOg6pA
	 wVn7q1sLMd72+Daf6HKACcMiO5CA7glsnhLvARmptnV2otvkcoyu9SxK+Qs2Lnc5Y2
	 wnicrsGNY2OOC1DHZHR7zi5Eqs4y4sRGxsxVdzW9+PVx3QrKJOuSK1xt1nR8O3VX3C
	 WtsVCTeOUbVmw==
Date: Thu, 1 Aug 2024 19:08:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: ngn <ngn@ngn.tf>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Nam Cao <namcao@linutronix.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: shpchp: Remove hpc_ops
Message-ID: <20240802000852.GA129961@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp-XXVW4hlcMASEc@archbtw>

On Tue, Jul 23, 2024 at 02:43:25PM +0300, ngn wrote:
> Remove the hpc_ops struct from shpchp. This struct is unnecessary as
> no other hotplug controller implements it. A similar thing has already
> been done in pciehp with commit 82a9e79ef132 ("PCI: pciehp: remove hpc_ops")

> +++ b/drivers/pci/hotplug/shpchp_hpc.c
> @@ -167,7 +167,6 @@
>  
>  static irqreturn_t shpc_isr(int irq, void *dev_id);
>  static void start_int_poll_timer(struct controller *ctrl, int sec);
> -static int hpc_check_cmd_status(struct controller *ctrl);
>  
>  static inline u8 shpc_readb(struct controller *ctrl, int reg)
>  {
> @@ -317,7 +316,7 @@ static int shpc_write_cmd(struct slot *slot, u8 t_slot, u8 cmd)
>  	if (retval)
>  		goto out;
>  
> -	cmd_status = hpc_check_cmd_status(slot->ctrl);
> +	cmd_status = shpchp_check_cmd_status(slot->ctrl);

This rename looks like it should be a separate patch because it's not
part of removing hpc_ops.

>  	if (cmd_status) {
>  		ctrl_err(ctrl, "Failed to issued command 0x%x (error code = %d)\n",
>  			 cmd, cmd_status);
> @@ -328,7 +327,7 @@ static int shpc_write_cmd(struct slot *slot, u8 t_slot, u8 cmd)
>  	return retval;
>  }
>  
> -static int hpc_check_cmd_status(struct controller *ctrl)
> +int shpchp_check_cmd_status(struct controller *ctrl)
>  {
>  	int retval = 0;
>  	u16 cmd_status = shpc_readw(ctrl, CMD_STATUS) & 0x000F;

