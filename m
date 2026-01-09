Return-Path: <linux-pci+bounces-44321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A7CD072FA
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 06:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BD8E3015ED2
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 05:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE72E42050;
	Fri,  9 Jan 2026 05:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNkXnJud"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82CF8F48;
	Fri,  9 Jan 2026 05:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767935949; cv=none; b=qeotQx91jIGa48ZG5B0vsnPfb3KL9vPdxLg9T9q17pcxlBQFme4oGnF1Y3PowcRdTk5goWoNxGcS4NFjkpC97tOT6bjY3BwaIQsxdLdiwebanLbgrDoC8ASZo3n64FkKohe/754QdVroLwG7AcmgkPsXg9D+gaMXC3HKuaNpXqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767935949; c=relaxed/simple;
	bh=QE+eW1lioXX0IuCt+nHwpU4h82uHQnaRvfgJbPKkX7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROMcKV8Xwr3gywicIwXYHNoYz0Cfqa9II+7WUV2AENs4pV3Cz1HG9/Y0zoUS4OPd5j8PIUsDl9KJ8xOJ5onSrdjFZJLrkNmcm5b4yz+yRVIEnyA/8AkSxcU5h26a/7gh208t0zoEkxksHDLYFkYJWbt/9y5Ywsiyr656k1jv3X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNkXnJud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE84EC4CEF1;
	Fri,  9 Jan 2026 05:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767935949;
	bh=QE+eW1lioXX0IuCt+nHwpU4h82uHQnaRvfgJbPKkX7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNkXnJudUJDV1z6JVqc2S9K5UxaVQiSyLAnFc6UtdaOqRwrQyTDSXwe8V3ar24iJz
	 9iw+ZJjGg0GsJRw1VBi8ROBj5xoOpOyFFJJyOTUqp8devgICXE4hcqkMoyENRPAeDC
	 NzUw3v5Fo7PQkc1KduHq0v9osYQzQsSAkv5GnsbCtJnJCaILCrPnURPxe4OC22cNil
	 yYgsLgiPblXX2oCBLnj9j3LESKIipeKxaG7H780aZriXuOztQKb8FwDxJZTo0vtHgP
	 sgP72yv9429H/c10Fcfo3vgfCZa7WopgZEw6qvq+QdZ7gjlpSN/3hSNXQ1S69lxg4p
	 Yyv+Tme96j8Yg==
Date: Fri, 9 Jan 2026 10:49:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 2/3] Documentation: tracing: Add PCI controller event
 documentation
Message-ID: <kvdwnbtbk6vac6mt6delxgyowp2g74cmb24kgmn5lqpmrbx66x@vscy2lbgmzj3>
References: <1767929389-143957-1-git-send-email-shawn.lin@rock-chips.com>
 <1767929389-143957-3-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1767929389-143957-3-git-send-email-shawn.lin@rock-chips.com>

On Fri, Jan 09, 2026 at 11:29:48AM +0800, Shawn Lin wrote:
> The available tracepoint, pcie_ltssm_state_transition, monitors the LTSSM state
> transistion for debugging purpose. Add description about it.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/trace/events-pci-conotroller.rst | 41 ++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/trace/events-pci-conotroller.rst
> 
> diff --git a/Documentation/trace/events-pci-conotroller.rst b/Documentation/trace/events-pci-conotroller.rst
> new file mode 100644
> index 0000000..8253d00
> --- /dev/null
> +++ b/Documentation/trace/events-pci-conotroller.rst
> @@ -0,0 +1,41 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================
> +Subsystem Trace Points: PCI Controller
> +======================================
> +
> +Overview
> +========
> +The PCI controller tracing system provides tracepoints to monitor controller level
> +information for debugging purpose. The events normally show up here:
> +up here:
> +
> +	/sys/kernel/tracing/events/pci_controller
> +
> +Cf. include/trace/events/pci_controller.h for the events definitions.
> +
> +Available Tracepoints
> +=====================
> +
> +pcie_ltssm_state_transition
> +-----------------------
> +
> +Monitors PCIe LTSSM state transition including state and rate information
> +::
> +
> +    pcie_ltssm_state_transition  "dev: %s state: %s rate: %s\n"
> +
> +**Parameters**:
> +
> +* ``dev`` - PCIe root port name

'PCIe controller instance'

> +* ``state`` - PCIe LTSSM state
> +* ``rate`` - PCIe bus speed

'PCIe data rate'

> +
> +**Example Usage**:
> +
> +    # Enable the tracepoint
> +    echo 1 > /sys/kernel/debug/tracing/events/pci/pcie_ltssm_state_transition/enable

/sys/kernel/debug/tracing/events/pci_controller/pcie_ltssm_state_transition/enable

- Mani

-- 
மணிவண்ணன் சதாசிவம்

