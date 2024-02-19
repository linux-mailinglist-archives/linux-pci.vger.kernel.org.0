Return-Path: <linux-pci+bounces-3718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C745185A15B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 11:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75315281E41
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 10:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0410228DD0;
	Mon, 19 Feb 2024 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="Bnd6OGNV";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="NQaWg/1U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96B824B5B;
	Mon, 19 Feb 2024 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339836; cv=pass; b=ZY6RqLUDlUXr+/OjtnGzmgFsXdVej6XTPJ1XJdSHTE48gE4Vtbdd8Ok5x3zjE1PtRmXFisCyPyk92ePgEjiE6mGcXphn1VnZKkxJRncPma5RPB6lpYZ1VK98FDK5RuTgLYATqf8isGKwITvOX7yD2N5vi5L0GcMR6LnBJncWhUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339836; c=relaxed/simple;
	bh=yI07zQ+jWsPFC3ueFt2YVm4gmvJXrfaBGf9cUxIYjfg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qctses95VAV+nd3IBqOqR1bS+1yJBp9NHoOxdRBNt9ADF3o86fBcLz6KGEqFmC1ovf+wZ4JAvRMy3XaKKBi80wfn+AOS0p6+55YYPffCM79hmo9+14RHakuTjJ1BscmoETJEu6yDIM8FCgOuPafBoS/dRvnHXAVLQlegB37PH/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=Bnd6OGNV; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=NQaWg/1U; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
ARC-Seal: i=1; a=rsa-sha256; t=1708339824; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BMI5Dcd7lcX9n50gnClE3URkLcs3Fh7HCv3kD9wPYeIjxMz5ZEJAu/wp48SXGADaDC
    cgk3lNWKCnryk54tHs/45YCSy3WIE3SIzOP/tHui/np5BoL3nYdUgqpwhmZSIbnrrM53
    VwbBg6CUSvI/xspLuVzSlXWBMa4THqRPbIKfTbosHVQtRwLwxrCrFxoDF7hFoGwb3RNy
    LpFS6rTUlRP50NwvBGpIf4T3Et5iSLdI4nqMRGHR6QvMa9Hfa9dTZHI8+lMOo1mRaisR
    inHmzPnC1D9Nahs0h60vwT7sna2mpupg/AoZWrPMvYpjTCZ1AeobbDFzNbqqho1Jik98
    bp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708339824;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yI07zQ+jWsPFC3ueFt2YVm4gmvJXrfaBGf9cUxIYjfg=;
    b=WKbwsWu2RFq/QkpkmT5pzpq5pqQqoLwwqypiwqvbWknvxUNNEouIrgih0Nn2682vT/
    boW/+aw8Z9sFmLsCKT3O3w1i4irUAaTolEWdrAUd2daI81KM766lHJMDem5LmUlEtwzH
    BqSKIaaIfqJnr1fJf1fea7MMNX0O/omEFZu9gyj8xbqJ7uVVMnVwVhK0FJ4oeB92pGBo
    nmI3qsRu8CZiJcpixmT+k72BvDlpoc1AfhFhxUoM+INN7bhtNS1ajfwDSjLLuCnWw/FB
    /rTxChcLXItJtRC+O9LcBffqxNncNBEGYbbyQ8/3ZaElw9P6MmkHRvUikAAhPaOFvO34
    pq3g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708339824;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yI07zQ+jWsPFC3ueFt2YVm4gmvJXrfaBGf9cUxIYjfg=;
    b=Bnd6OGNVt7k3i/G1+hAPvA4VxQLJsFrSlN9mwXC6k3nf481JnAp75UUjVw0jt5AGRe
    yyd4ar8vMusSR+T7asAhhEEaGIc9MSitBxlMWmGFtEO5VCYkHfXbR+JVqEaXUYny+Er1
    4a93HNdykCJ5ToeJRNnedTZzff7YLSGy52RJoTZvvJd/RvjiWuU/yrlBjx1Tv7FqtX8M
    UMADqOK3c1/+YRteMSIUzax0iM0IEel7C+b7FciRAYA3hfdq7y13+vnuj1D/FI0Apy8E
    LFftUkFBv7Um87zLsSeQhSXMDR+WJQzHulkzWVRZwyl8+R4QQ7meQWtdRkooZSgyye3v
    rWAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708339824;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yI07zQ+jWsPFC3ueFt2YVm4gmvJXrfaBGf9cUxIYjfg=;
    b=NQaWg/1UvEG3YDkp0pKCWcClEHAk6xqOKCxUy/DybByDlZhsXkAroKHwrn5dLSXLVx
    +IuIwBMo663TWyDbwaAQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
Received: from [10.176.235.119]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id z34ed901JAoOFUk
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Feb 2024 11:50:24 +0100 (CET)
Message-ID: <82320769f502c5fadad90f1ec8d782c6ef423f56.camel@iokpp.de>
Subject: Re: [PATCH v2] PCI: Increase maximum PCIe physical function number
 to 7 for non-ARI devices
From: Bean Huo <beanhuo@iokpp.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  bhelgaas@google.com, schnelle@linux.ibm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Bean Huo
	 <beanhuo@micron.com>, stable@vger.kernel.org
Date: Mon, 19 Feb 2024 11:50:23 +0100
In-Reply-To: <4858e202-6097-493a-8405-86d3e8e17c83@linux.intel.com>
References: <20240216190113.20341-1-beanhuo@iokpp.de>
	 <4858e202-6097-493a-8405-86d3e8e17c83@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-16 at 14:26 -0800, Kuppuswamy Sathyanarayanan wrote:
> It looks like for an ARI capable device the limit is 256. Why not add
> that
> check as well?

" With ARI, the 16-bit field is interpreted as two fields
instead of three: an 8-bit Bus Number and an 8-bit Function Number -
the Device Number field is eliminated. This new
interpretation enables an ARI Device to support up to 256 Functions
[0..255] instead of 8 Functions [0..7]."

the above statement on PCIe Spec highlights that since the Function
Number field in an ARI-enabled device is 8 bits, it inherently supports
numbering from 0 to 255. Thus, there's no need for additional checks to
limit the function number to this range; the 8-bit size of the field
naturally imposes this limit. This efficient use of the available
address space aligns with the goals of ARI to enhance device
functionality within the PCIe specification.

Kind regards,
Bean

