Return-Path: <linux-pci+bounces-26108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CBAA91DE9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 15:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F140E3AA79C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 13:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E61824339C;
	Thu, 17 Apr 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="GMO0DfTG"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender3-op-o12.zoho.com (sender3-op-o12.zoho.com [136.143.184.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D40245029
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896335; cv=pass; b=CgfRJ3l/KdKKXLeh5cfUIRBp3whzlbTs0qIiP36asNb8H4Qr4ICUFOaItQVHp3WY+zRIFinU2x7TOt4CXWuymIPGteMK6T17UZKMV4ibVAGhKGCR+TzGWYcrcZug4wCep2UkoBY2BoglRWAyLuoyJFmyJkhRVskPy9ygroglzKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896335; c=relaxed/simple;
	bh=fQHVI4FXMoRZwKY2jcFdWDi98I+vbDUpgl3+On9x46U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xs2ZI6vxjUb27SgL7JJV/EW/dqGB1ex4jMpXIJepS2tqMxLNYZczaMZx1akbjzcfn72mGCyIfCtxEuGVMOWJEPLVWfTnWTiSdBxAQ6aYUIxdKUdPgy77uhSqa9xOQdOb7Q3Dtpdxut0aOxN+ES13XCdSMJY+YzEFTtwKpIytAV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=GMO0DfTG; arc=pass smtp.client-ip=136.143.184.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744896281; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YAmwjfcVx6oWeXIlV6PGnxiPWIz9cGSHql1PaH1BddCIt+Rdv/M5nMIsXhz46mehEWVse6RUGTsHkCTdUVTqr/o3TxDWpo2EOvYL/EmezmWtKbt97pWtajhBU7OFQB6+huGRexlOjpA8OrFJumN9Xjp02JSzeqf451KAXWS4d+0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744896281; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ayh36aU37peKqpZXlZgTNqposmDRisWCEwR5u33oTrQ=; 
	b=JQ+tv3lgH37E6MqdKPKGEy3GDUB+RzMddP+uSptWMfjAaIahva/z9gyVdM20LJoLQt4A36gXt1RwiTcr007V1ptJxfsHywteRDLdEcD8c4TRv6J5kmD0F3aPDcC1yRhwO+I0lAuxKufA+gRv5kEx0FjwnA2F/GjpvQGu9PYx2Q0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744896281;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=Ayh36aU37peKqpZXlZgTNqposmDRisWCEwR5u33oTrQ=;
	b=GMO0DfTGL/gkCxhxrrrVE95dpQvS5S+K+uscs/WH9tnvcj6/FJK6+H0hPJSJ+Akt
	aHG3KmRqRfMz21Z18WqC82wAWaWs6x19eOkBMhrFQ7OIdeEs+7qv2DyeNX0L8JsXhEi
	C6Vpc46OWPHE0XmdthDDPowEIFulBx+f17G0CvHc=
Received: by mx.zohomail.com with SMTPS id 17448962784846.708394728524695;
	Thu, 17 Apr 2025 06:24:38 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Add system PM support
Date: Thu, 17 Apr 2025 15:24:34 +0200
Message-ID: <8815983.T7Z3S40VBb@workhorse>
In-Reply-To: <Z_5aib0WGKfIANj_@ryzen>
References:
 <1744352048-178994-1-git-send-email-shawn.lin@rock-chips.com>
 <Z_5aib0WGKfIANj_@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 15 April 2025 15:09:29 Central European Summer Time Niklas Cassel wrote:
> On Fri, Apr 11, 2025 at 02:14:08PM +0800, Shawn Lin wrote:
> > [...]
> > +      rockchip_pcie_ltssm_enable_control_mode(rockchip, PCIE_CLIENT_RC_MODE);
> 
> Here you are setting PCIE_CLIENT_RC_MODE unconditionally.
> 
> I really don't think that you have tested these callbacks with EP mode.

Hi Niklas,

I may be reading too much into your tone here, but I think it'd be good if
you didn't formulate this in such a passive-aggressive accusatory way. You
can just express your concern as a question about whether this was tested
with EP mode.

After all, I'm giving you specifically the same benefit of the doubt with
RC mode that has broken BAR resource mapping on RK3588 in timing-related
ways in v6.15-rc that has already taken me about a day of unreliable
bisects to try and track down, and may in fact end up bisecting to one of
your recent commits touching that part.

> 
> If we look at pcie-qcom.c and pcie-qcom-ep.c, dev_pm_ops is defined in
> pcie-qcom.c, but not in pcie-qcom-ep.c.
> 
> Perhaps it is starting to be time to have two separate drivers also for
> rockchip?
> 
> [...]

Regards,
Nicolas Frattaroli



