Return-Path: <linux-pci+bounces-8197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C818D8A7B
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 21:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D007328AF3E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 19:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03F13A416;
	Mon,  3 Jun 2024 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ML+J9YSW"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878713A252
	for <linux-pci@vger.kernel.org>; Mon,  3 Jun 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444186; cv=none; b=kxdNc++Y6Cqv87y9p7ejyupTxhMai4QgtUoZKjS6NIBSN/eH9569E9Ajzb5P50eFWMGdLILIRBoy93/5hHJM98UtUITemlXiWliUFD30gJENeuGP0IulZoNjijroTZ7iYWlNA4mOXugerMxiKnwg3p1yyu+Je23MrazX3TNqlRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444186; c=relaxed/simple;
	bh=WEuqUnPNAb1DI3EqIJBqZFbfACrCPb2rQr3u0PBTUnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJZ5Bz0ICzCc23VqbsvUigfA5nt8uCoUC1uUR5B+/vJbgTJBAQlz8De3noLg4O/TNBYyXgcgX2hiddMLCOmEpFF6SOIuQkZIe9mhj/Gs+Q20+xe9PPe4LRaEVKfum/14Bx/TkFXJNswICs+j3ywHnwZh70LyTmblruaYAh4WhQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ML+J9YSW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717444184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXGaVSP1cFFNV4dEuxpxTKr8wpTXGnmFrUnlz6ILBlQ=;
	b=ML+J9YSWyrSiml63zGNTf75gzmPnXxMjNd44pknWMQpQiZQE4Gujnh4Si5NaR+eItVNN3N
	fLhXpWTRPbNaIQahxKV18gfv7gpshTGNtOeVFK1pMhf+9vbLBib8ZdQlJ+sOc243R2Zd/S
	ZTCbOs3htg/zFTB9wSkLyNa8oH4DhKM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-iCUyvDS-PUSAdJJCU801vQ-1; Mon, 03 Jun 2024 15:49:42 -0400
X-MC-Unique: iCUyvDS-PUSAdJJCU801vQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2e95a1fae88so37729681fa.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Jun 2024 12:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717444180; x=1718048980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXGaVSP1cFFNV4dEuxpxTKr8wpTXGnmFrUnlz6ILBlQ=;
        b=MPlyBPbmp0EzJUFM6scLuZmkoexlyHPB3Aipj/5R03Xith8qpC87jq4cSttGxVTgDC
         j4RoVT+OkOC5YMZhwKPvrnxw5EGWZE/tPmVYNdDxoD2cc4EkW2JJytA2XYVsnk2jtepB
         XVGsxktuwb3UZA43+22AS7HnbO6nGszYDyXcnpsBmF8g0tb4kDcUYquskLOJx33dluxL
         k0w7+R4xaSjIRazIaLiXtvlkijKZhjycB+C9ySPBGgaWm1+pHcHw6eMA9oxXHrlqulbA
         +N0zgMiFGV54cPK332MShJna8nfSF19FzawUVrFtTly6R7XZNQDHF2mpkri/9NDUIRNx
         Mzsg==
X-Forwarded-Encrypted: i=1; AJvYcCWFnFnrB83Q4DaQbiASeh0bTu1uToYwih/TDAyDELGgf3/GrJ8yLJG5xwbEoCuSYREaWWWTo9s0tpAkT/FMT8cLe+0OYeGi8PKT
X-Gm-Message-State: AOJu0YzVRA0j2mJ824qN4IjU1mE1c64QWKR4APw+ak5kYhpvblMVCWuT
	+/WNBKbsYT0eaU588tiS3YZVvNIK2/CB8DRR1D0+poCYoZfNeiBJbuJgVtPuQo12ikcKAf8dVo6
	64YqwFJzNz3+npB1x4f/+a/KJW0O2+MLNH97Sm/CAnybpc0fEx2szqGJBVg==
X-Received: by 2002:a2e:3202:0:b0:2e9:855b:7014 with SMTP id 38308e7fff4ca-2ea951d4f58mr62232291fa.44.1717444180539;
        Mon, 03 Jun 2024 12:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEicqFjiXcHgBKsP0jWUx0Z+oQW/Wff9OVSRmKJxZo67GkVZu0wQOBVc6oYllXdv3vKAq4B5A==
X-Received: by 2002:a2e:3202:0:b0:2e9:855b:7014 with SMTP id 38308e7fff4ca-2ea951d4f58mr62232191fa.44.1717444180125;
        Mon, 03 Jun 2024 12:49:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c9c0c4sm5970261a12.83.2024.06.03.12.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 12:49:39 -0700 (PDT)
Message-ID: <6daf3a21-6e78-4a82-b03f-af9462fad012@redhat.com>
Date: Mon, 3 Jun 2024 21:49:39 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] PCI: Revert / replace the cfg_access_lock lockdep
 mechanism
To: Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com
Cc: Dave Jiang <dave.jiang@intel.com>, Imre Deak <imre.deak@intel.com>,
 Jani Saarinen <jani.saarinen@intel.com>, linux-pci@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/31/24 3:04 AM, Dan Williams wrote:
> Changes since v1 [1]:
> - split out the new warning into its own patch (Bjorn)
> - include the provisional fix to the pci_reset_bus() path
> 
> [1]: http://lore.kernel.org/r/171709637423.1568751.11773767969980847536.stgit@dwillia2-xfh.jf.intel.com
> 
> Hi Bjorn,
> 
> Here is the targeted revert of the cfg_access_lock lockdep
> infrastructure, but with the new proposed warning for catching "unlocked
> pci_bridge_secondary_bus_reset()" events broken out into its own change.
> I also included the proposed fix for at least one known case where
> pci_bridge_secondary_bus_reset() is being called without
> cfg_access_lock.
> 
> Given there may be more cases to unwind, and the fact that I am not
> convinced patch3 will be problem free I would, as you suggested,
> consider patch2 and patch3 v6.11 material. Patch1 is urgent for v6.10-rc
> to put out these lockdep false positive reports.

I can confirm that this series fixes the lockdep errors which
I was seeing:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> ---
> 
> Dan Williams (3):
>       PCI: Revert the cfg_access_lock lockdep mechanism
>       PCI: Warn on missing cfg_access_lock during secondary bus reset
>       PCI: Add missing bridge lock to pci_bus_lock()
> 
> 
>  drivers/pci/access.c    |    4 ----
>  drivers/pci/pci.c       |    8 +++++++-
>  drivers/pci/probe.c     |    3 ---
>  include/linux/lockdep.h |    5 -----
>  include/linux/pci.h     |    2 --
>  5 files changed, 7 insertions(+), 15 deletions(-)
> 
> base-commit: 56fb6f92854f29dcb6c3dc3ba92eeda1b615e88c
> 


