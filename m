Return-Path: <linux-pci+bounces-3722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165D585A2DF
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 13:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B33283A68
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 12:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1132D05A;
	Mon, 19 Feb 2024 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="SpodSi7z";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="l3tiWElU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D484C2DF9C;
	Mon, 19 Feb 2024 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344566; cv=pass; b=g0y2IxYXAe7qSub1lW/NXsCADapRRvZqbPrZJjMbESRkxSuPcc1bD/cMa8PZjfnvpWsthAhR7mlWTCgHhDaOGY/EumpbZ1tlV+WrxItPLkx3Zf8ZK49pE1GSubi4P7WH0LxbrLRIeV7wkB8U44yXocYO7JUS3QYPcK49dD+9Aec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344566; c=relaxed/simple;
	bh=AjrVEp3fpkZRCO/o25RmtJVX3tFJ8i0+SruCDOkqxVc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PKZgYT/JkUOBQPK7u63GwepypgIV0VrVYzR02A7J2CpoBjLFZNjPN8EAR/O+B4F+MHVjRRH4GIziAA9un2oqf9/YVEyEtZ6rKRLqDP5OFVZVEs5tFuq4xI+Lh+uV/mcjeN6XcAXlbH+HF1GNLxk7YOQOjQs9nuteCScZj/AncHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=SpodSi7z; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=l3tiWElU; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
ARC-Seal: i=1; a=rsa-sha256; t=1708344556; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qcCuu30vrT9ipND9ROtbvG+H753q3gyJ4pvPZo0p0jDe+PLmdxKqiNoBkXgGL01um0
    u2bcJDBrLzNNgSCIix/D3bnfcjN3N0ty1Pi59XGnEAbLeXLZFrP44yxHlt6DgYxBfE5c
    SIgPu6DnEmDG35wCtY0VZ8kT9bzFAPGQQ1njmAlNQyo+1IzON7vu1pY+K/LRirg62VG/
    GSEkQwTEpfUW6aysGnhd+ClmofgBDF4DfaoELM2hKyS/ichqAcVvqmNMqSyD4JIRjS34
    e067damlRfMPf85/1ZvtCvy347kvJrwRfk8+Urwo2hYnryJC+5KfYRiwv9wIOFLNczSF
    X6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708344556;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AjrVEp3fpkZRCO/o25RmtJVX3tFJ8i0+SruCDOkqxVc=;
    b=U/N6tOSurMwh9euZTjLenRadLMg+TvdrX9Yc8jqydZQbj0hHTY9mgt0iEdRHuRxtyX
    acTrYx4/slsIXmPtHL1qW7wSlJDb/k1tu6FG1fYlNZO6jyJ6ClYjexmrHJpKKYhWG2EM
    /UHIRUMC0b8qCMKLBEq9QNZrt4NzUXaHrlmpxJBXC5MrupGfh4gy2UQj5g+MMECYawLB
    omdr+Y8pf+t09JUB5tg/wJAqr0UST1433TnS2OCIU6ReO9iwR5o8C4B37kdPvNMQUk2R
    /QHqYlXZ08K1+UYYl66fzMvUxHwfxY2CAS0MoGYot0M9z21VyijkjkAMtkeetAYSC3rw
    EtMQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708344555;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AjrVEp3fpkZRCO/o25RmtJVX3tFJ8i0+SruCDOkqxVc=;
    b=SpodSi7z0nOve6xepgf+5NIJ3W/dFpmsvbfyQ2CNNGRTaGc1iSgPkZLcdFLMmh4r5N
    lZZ4Mi4aGk+m9r2jLQft4nL+IW6MxE1Y29VLZubaq2JaI+g1SxPOIYsKNuzRVkDQ5Zim
    qX+sJVtbt40Bq+bulrWE/KCEMEEr3aS9uqi7z/+0glwYNHa3ws9tOouNh2ngJM615cZ6
    GgRu2w6k91okdtZbX+2laOjcYmouHqn1mr/4fnC6E7+XYevKJHz/cMnEM6Y8R4xJQrqj
    +nAc/vwDa9zMbXzjvyNLplcRBro2bJwCveksLLayZlYZFucQvvPGwWmZRLEc0Gm1cdrp
    10jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708344555;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AjrVEp3fpkZRCO/o25RmtJVX3tFJ8i0+SruCDOkqxVc=;
    b=l3tiWElUoTRAGkwsTxJHK4fOZt2M2ZKN/F4JiVqegz2UlxKYdDF26KL89t/pAAl/SO
    hFfuhpMCYWdlsK9qkbAQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
Received: from [10.176.235.119]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id z34ed901JC9EFwE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Feb 2024 13:09:14 +0100 (CET)
Message-ID: <fe5d0d5c3cdebc8d637c348f3759330166604bb0.camel@iokpp.de>
Subject: Re: [PATCH v3] PCI: Increase maximum PCIe physical function number
 to 7 for non-ARI devices
From: Bean Huo <beanhuo@iokpp.de>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, helgaas@kernel.org, 
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bean Huo <beanhuo@micron.com>, 
	stable@vger.kernel.org
Date: Mon, 19 Feb 2024 13:09:14 +0100
In-Reply-To: <37d21806-d964-40e0-a5a5-3173996e601f@ti.com>
References: <20240219112422.54657-1-beanhuo@iokpp.de>
	 <37d21806-d964-40e0-a5a5-3173996e601f@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-19 at 17:30 +0530, Siddharth Vadapalli wrote:
> The function "next_fn()" seems to provide the next valid function.
> Therefore, if the current function is 0 (fn =3D 0), then the next valid
> function will be 1 which is returned by next_fn(). It extends
> similarly
> until the case where current function is 6 (fn =3D 6) which shall
> return
> the next valid function as 7. So all 8 PFs are still treated as valid
> and there doesn't seem to be any limitation. Only in the case where
> the
> EP doesn't support ARI (there is no function 8 (fn =3D 8)), the call to
> next_fn() with the fn parameter set to 7, will return -ENODEV which
> seems to be the expected behavior.
>=20
> Regards,
> Siddharth.

yes, you are right, the fn 7 has no next_fn, hence should return -
ENODEV.=20

ignore this patch!

kind regards,
Bean

