Return-Path: <linux-pci+bounces-26552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16522A9905D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D1EA7A9582
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184732918DE;
	Wed, 23 Apr 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lmauy6Ji"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A9828E61A;
	Wed, 23 Apr 2025 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421130; cv=none; b=c9dGNqNhfAXAecUZHr5IRdC1nK8FCAjU+js8AlUEpmuVzsA9HqVi1N6h/pcETXFRfp57hZrs3E5+radUzd02KhfwUB2lrAQxDtb+by2v8Z5TWp3Qu1z5t+EO6y28TQaat1s+9Ja+6GK/Nvmjk5iv+LhsFfSPFc3tOJJHEp7FdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421130; c=relaxed/simple;
	bh=rDayEnmW5wOjUNCI7vo/8BM3UfjynySd1YOsFEmc0Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klr+MnAxrzvARgPS2eRij68pMbW1ikRh0lPRvZ2qHwre5VLuzi752Xu5DvLZhw8wHwimRA3G5A7rc2sNredbl8Pth+0/QJlPYRPcKDsJjK6MV2kOE8HnetqWs7ca/HMEnOZaUqZk67rH2wgiHC9rZrC/9VsdC9nPLR6y1fE/WVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lmauy6Ji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF997C4CEE3;
	Wed, 23 Apr 2025 15:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421129;
	bh=rDayEnmW5wOjUNCI7vo/8BM3UfjynySd1YOsFEmc0Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lmauy6JiNq31WB8nrkpG+4X/sEHthcQJQm2py5Vba/EmUN9bzIRhSR0UvV3/zkITx
	 dGqyTsFQ4MTM/5leecxr54xpAW57wuUiBTQ7h9eWklX+q/7l6y40/qDaDPpwJhG+Va
	 xWZslDaKQkeSPAGLQGXwfO7zpv/OdzggwUNWaIbjX5YeTMUi03qR4caFTORBEIvjns
	 z5stAHX+gU7cyJ1ASUYCytTFa7gtSzeScWqE3zI8TU5EOFN72logSZZanzybyfYVqF
	 SHAiqUiWEdKGMuP2VBpdB5SWiUIbkx01wEx7PkG2Chytgur6o3doj7Pg1iazdD4y2R
	 BylRBMaA3C1PA==
Date: Wed, 23 Apr 2025 17:12:04 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, shawn.lin@rock-chips.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/3] PCI: dw-rockchip: Reorganize register and
 bitfield definitions
Message-ID: <aAkDRIqIOjLo7haw@ryzen>
References: <20250423105415.305556-1-18255117159@163.com>
 <20250423105415.305556-3-18255117159@163.com>
 <aAjufPQnBsR6ysAH@ryzen>
 <352e40a0-65e2-499f-a7dd-904a4a7b19da@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <352e40a0-65e2-499f-a7dd-904a4a7b19da@163.com>

On Wed, Apr 23, 2025 at 10:14:57PM +0800, Hans Zhang wrote:
> > I can see why you renamed PCIE_CLIENT_GENERAL_CONTROL to PCIE_CLIENT_GENERAL_CON
> > (to match PCIE_CLIENT_MSG_GEN_CON).
> > 
> > But now we have PCIE_CLIENT_MSG_GEN_CON / PCIE_CLIENT_GENERAL_CON and
> > PCIE_CLIENT_HOT_RESET_CTRL.
> > 
> > _CTRL seems like a more common shortening. How about renaming all three to
> > end with _CTRL ?
> 
> I saw that TRM is named like this.
> 
> PCIE_CLIENT_GENERAL_CON / PCIE_CLIENT_MSG_GEN_CON /
> PCIE_CLIENT_HOT_RESET_CTRL
> 
> Shall we take TRM as the standard or your suggestion?

Aha, so the inconsistency is in the TRM... hahaha :)

Probably best to keep it identical to the TRM.


Kind regards,
Niklas

