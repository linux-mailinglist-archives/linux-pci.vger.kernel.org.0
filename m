Return-Path: <linux-pci+bounces-40005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42467C27900
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 08:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A62C234B366
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 07:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C4E298CC0;
	Sat,  1 Nov 2025 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XtrW0Tin"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94454232369
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 07:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761981983; cv=pass; b=tNS2WXK10sEtAnzEvvz8QBYQdHFZq3t1y1VKl+9DBj/raZIrO3TKqkX70C6GzsvbBRQIw1wldOHCQeHAl28XmKRfHJr6wO9OFImRJ1HpMgs0ixxBYKTBXF7uKah5ThzRgE32b8zp2XwBKTsoWewtmzTgBaVJX7Eiez6UNb3Wfxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761981983; c=relaxed/simple;
	bh=zf0ZLdLuOyobo4FqAPCgYvYFsUlh78ww5n39DM+3PDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9dBWDcwOaRUeSRG6sqaU9u0bfwICp4E1Np1jLosHXamO6zQQxlJ1mFkjc4fv8ZmS2o1t64QzaoYE3eLOuy/DulBidRI+wEx7LEX6RAzAWSgTeo9s5TDRZVbsyMT0W9FkgLhxhGdJyCYjUi29QL9C1dT6usrorlgRsvC8FGHIdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XtrW0Tin; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1761981971; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pKg4+LlQnDC0Gv8ZjfGhiLsRr0XiT+25vljgCczdQMmNxWMoeO7kIO2mWhdwmOlA/D
    gRiBl72Dnlx4WlDCqMhc+JAMdOVgSdBD20hIBjP7q3OhfVd8P5GAxRl2va9A7MdcycBQ
    ZodkbreowhThlIowU4oj5N+oISuLg2gBKhL7l+g/1SKEKouarm8+/PDsfcWDYYnINktV
    xmE+zs284u3/PKsskgyl0SQA/wLflDt5L4yO8IuA/wGpNmvaMRFJwjl4UMzM3BjC5Bpp
    +ywHf0BwZZ9+WiNUdT6Qk7AqyEa/EIiO8Tslfo/mZvDD5ad9bur57lACJneruOPTKhCU
    vqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1761981971;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aW7wdF7ichDP/PYY8hx8xNMPqshujHNItIiXbFK9FmE=;
    b=UBG+psn6/jU9Z6/L4ntUt0kZlS7DJqarB50lufwFdoQ5dhYVH7QEUjgmUJ4Ly5hL5n
    Eu/u63n67u2gs2a2C0uCO6gBMqzfIgsP5XQXMX9R0DL0bt7HLmGCg1mykS5YreMNBZeG
    yMR/Axwa1qUkKGHXssaFOqTfmh0xtkSKuL2Al32m36zng3NOl0KOxv1WfvArYNYV5xwz
    jDyiTANQ04ah14eWwuNkfxfXMfNPpu5cEi1MmRuEcWzMjMgXFok8axcm0+iiYFWDPSiu
    b5wlSPFrf+2MEKDTNvhYY4OtESCQdRAj4VZvW2BwyVRlMEZL5J5KyT5bh3WMWT2I6JuB
    yTVg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1761981971;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aW7wdF7ichDP/PYY8hx8xNMPqshujHNItIiXbFK9FmE=;
    b=XtrW0Tin+Rumtt02r+5W7bClT2wYNbjG45XxnobdrpzeYV8ShQXss+1Gwk5B71qbSa
    wh5milZFgY+/acjN4yycC5gMSoy+nBuHe+GGB28jfjnqKCwf8+q79Sn62vJy4H83BXEF
    o6lsyOal3u2DGQLPMnnJ9wC3WxvFfmmeXYJY1iagf6aGlOJwamWL1W1hKbwW357njO8d
    LiDUUXmg7E/+6ybLHgbTcDjzdyy7z7wPQewDZhq1vKMvvHqgxJx5g8TS37xrNAy/lAxN
    9JnheDqApfTe58AY8tBMTGQeGcwxw9i9/olKu5o7CqH+acYzWV9h0+Jx2Tky+s5o8F6R
    +QSg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id Kf23d01A17QAtTU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 1 Nov 2025 08:26:10 +0100 (CET)
Message-ID: <61361204-9b4d-4b3c-9fb4-e11ba7f1888a@hartkopp.net>
Date: Sat, 1 Nov 2025 08:26:05 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCI/MSI: Boot issue on X86 Laptop 6.18-rc1
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
 Christian Zigotzky <chzigotzky@xenosoft.de>,
 Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev
References: <20251030222934.GA1657337@bhelgaas>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251030222934.GA1657337@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks Bjørn for keeping me in the loop!

Have a nice weekend.
Oliver

On 30.10.25 23:29, Bjorn Helgaas wrote:
> On Wed, Oct 15, 2025 at 09:05:11PM +0200, Oliver Hartkopp wrote:
>> my Lenovo V17 Gen 2 (i7-1165G7) does not boot since commit
>>
>> 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
>> ...
> 
> #regzbot report: https://lore.kernel.org/r/8d6887a5-60bc-423c-8f7a-87b4ab739f6a@hartkopp.net
> #regzbot introduced: 54f45a30c0d0
> #regzbot fix: e433110eb5bf
> 
> 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
> e433110eb5bf ("PCI: vmd: Override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info()") (appeared in v6.18-rc2)


