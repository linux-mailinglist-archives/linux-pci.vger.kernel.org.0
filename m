Return-Path: <linux-pci+bounces-42357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B36C96AFC
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 11:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B738E341F57
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 10:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71233303A39;
	Mon,  1 Dec 2025 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHMaBxww"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48209302CC4;
	Mon,  1 Dec 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764585434; cv=none; b=eKGzXrxlT4Ipi/MuXjSK51+Scqp5QO3dAWmOgerTIdILZpsjyivTy354fnPRGJcU5tvFboM2lwrynsITHDx6OQ6qIwiyuPTlu9I6TQ6UZc8TP7UoKU9zTHh50eyTFdVqvjEeCs4Y8K98hIWbgm8uagxhjot94uM8HxKnn25fpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764585434; c=relaxed/simple;
	bh=ASAg1WLeB2U9cM3GwF+7PUWohB0B8mcSABdKqtv9qpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1v+Y8IrW3Bd1pg3c0DhVzNa8GwFnkNFTO+Nfq/TaKuUbK7TErzD76BOjRbUTxxj20PuaW2Xtba3fe1GeeL0SeZNd0v0C8fPRuSpQcHuujyaloEE0n4okZk4R52JUhIaLzv3hYrOUp3cMCpOy7nWyplRcsyVWXeiin0gTbnE3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHMaBxww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741E3C4CEF1;
	Mon,  1 Dec 2025 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764585432;
	bh=ASAg1WLeB2U9cM3GwF+7PUWohB0B8mcSABdKqtv9qpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QHMaBxwwNjkD6TarGHvIOtGhMU6OGTpzOmDsoHM3qstx75ZIYjpaPKu/c3P4KtzSp
	 8BM5FPLRe8s/C8VBI9slBwNbW7F7kgNqmSXEoOI7Fux5x7yaoOu+fIz5dPt7h+9PmK
	 ZB3XeY2lLvn+So8jSfLIaiKT6fQzYoithsyxobsCVOMGnwi3GiLTJX85kgSG0vBZ4L
	 TW3p2UeGkhMc5upRLZPAtQv9o5aIUCSHSDfdxMNVif+Q5Qq3TVjALUBlY5R2FFYdU6
	 tvI7/AoXruw+WNc5+OThsm1+osERFJ5aUNHhmv4NttNOhaMrjveqBELtwsnSkc3mqf
	 01zUqi+9I9RAw==
Date: Mon, 1 Dec 2025 16:07:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Alexey Bogoslavsky <Alexey.Bogoslavsky@sandisk.com>, Jeffrey Lien <Jeff.Lien@sandisk.com>, 
	Avinash M N <Avinash.M.N@sandisk.com>
Subject: Re: [PATCH v2] PCI: Add quirk to disable ASPM L1 for Sandisk SN740
 NVMe SSDs
Message-ID: <jkj7rk3eosohklyml5wicid4pamahbeqjroosfomherkd4sxdx@qyduw665jhzf>
References: <20251120161253.189580-1-mani@kernel.org>
 <20251124235307.GA2725632@bhelgaas>
 <tiadpmogdxom5h2bquct2ch6hoc6ozh6bgnzdmnj3mia22vtue@c5yjxbx65lsm>
 <9a9280e7-d29a-475a-83fa-671acfab9d92@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a9280e7-d29a-475a-83fa-671acfab9d92@packett.cool>

On Mon, Dec 01, 2025 at 03:48:13AM -0300, Val Packett wrote:
> 
> On 11/25/25 2:21 AM, Manivannan Sadhasivam wrote:
> > [..]
> > There are a couple of points that made me convince myself:
> > 
> > * Other X1E laptops are working fine with ASPM L1.
> > * This laptop has WCN785x WiFi/BT combo card connected to the other controller
> > instance and L1 is working fine for it.
> > * There is no known issue with ASPM L1 in X1E chipsets.
> > 
> > Because of these, I was so certain that the NVMe is the fault here.
> 
> There is *a* known issue with ASPM L1 on X1E, reported by maaaany users on
> #aarch64-laptops, that we discussed in another thread..
> 

The other thread you are referring to is this one I believe:
https://lore.kernel.org/linux-pci/21398de7-3dd9-4c43-97d9-7c3002c401e5@packett.cool/

From this, I cannot conclude that controller was at the fault. Atleast, not
until now.

> But it is a full system freeze, **not** a correctable AER message, and it
> definitely happens with a bunch of various SSDs on various laptops. I
> personally have had it happen both with the SN740 and an SK Hynix drive, on
> a Latitude 7455. It's an SSD-only issue (disabling ASPM just for the drive,
> but keeping it on for the WiFi, was enough to get to month-long uptime) but
> not specific to any SSD model.
> 

Please confirm whether you disabled all ASPM states (L0s, L1 and L1ss) or just
L1ss for the controller instance where SSD is connected. Starting from
v6.18-rc3, only L0s and L1 will be enabled by default without any
cmdline/Kconfig changes.

> One bit of news I have about it is that I recently started using EL2
> (slbounce), and I did see something that looked like that hang.. but unlike
> in EL1, right before the reboot the panic LED did start blinking. So if that
> was indeed from the same issue, I should now be able to catch it into pstore
> (if pstore works.. trying blk with sdhc instead of efi now 0.o)

That would be helpful. I guess Abel did it on XPS13, but need to check more.

> Maybe QHEE
> was eating the fault and itself crashing, since it "owns" the PCIe IOMMU
> when it's running.. (???)
> 

Yes, they all are captured by QHEE for post mortem analsys that could only be
performed using Qcom tools and on non-production devices. I don't know how to
capture those logs on production laptops.

Anyhow, to isolate this issue to ASPM L1 on the X1E PCIe controller, please
disable all ASPM states by selecting CONFIG_PCIEASPM_PERFORMANCE in Kconfig and
let it run. If you do not see the crash at all for some time (or days), then the
crash was related to ASPM issue in the controller (since you said the crash was
repro. with other SSDs as well). If not, there is something else going wrong.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

