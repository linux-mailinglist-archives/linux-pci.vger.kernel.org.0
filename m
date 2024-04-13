Return-Path: <linux-pci+bounces-6218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309B78A3E90
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 23:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CBB1C20AC0
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 21:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A985453E3B;
	Sat, 13 Apr 2024 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWmKSF1w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06D4D106
	for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2024 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713042082; cv=none; b=r1R4ZwfFrFv65mQNW6JXlIsegAdQxrYKmRrQldY+Pg6ZqocF1iGBJkLzmaj9PWVaN41elVGV0eDbFHDhiWAYlDI7arUSvptANcvzjIBPVzXLEvTR0dEBH4My95GrvOlYBxDn7FuIOiyXHC8DxFyFaYgwFcOCnSloV945Cv7O02c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713042082; c=relaxed/simple;
	bh=AutqEzy2oqbK17kWUfhNtOruZpVN2n3EfnR+jf+IqdA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=a9+7ym9cFv051NUbHoWb8jKnQvnQubPXU0SGAaEtCdPe/s4NbK1eYFbUug7twBFoZbbCwEhlxzHXZkjQ/8TB7BAzVMApq69XunrhSUvmGVVsrWqv9f9DmBp+briP+10jOQZtgOUjf5tTR7sYbrheqoBBCYdDzH7i4fovgdfq8p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWmKSF1w; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so2903539a12.2
        for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2024 14:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713042079; x=1713646879; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pw4qbR9A+GSAMahp/yy+ZAGWYyaHrjVRWo8Z7Wm7D0c=;
        b=XWmKSF1wZzVyIN8wGHBCpsU9vBCAl1xZ4MC0mnCqHWwPP6/2sfK5XJ86Dls/wAmSIq
         b9yGKpX2MmGoB07jDtv7JsxCh0bTM8/eJI6lhUPTW+ssr5XjAlb0et4dWzeUBqxDO1wO
         6iud7nMdDCUNx96coYrMcqcR6mfnb0MDdEWCU4pa25pnYrSpOBZpVtmQ93LG8MeY3d+T
         eRxg5xtKSrrVE4WBFN8HLWKKiUZF6szQtZKI1yUUZdcA1o0a6TaMFzij3HnaFYiUK12r
         7+upuciLLFx30dA/Dd4ibeBaLWjkTIPU3rdfvtAWz58GMhugqB5feO7X/gtz7Rxp+Nhz
         /q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713042079; x=1713646879;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pw4qbR9A+GSAMahp/yy+ZAGWYyaHrjVRWo8Z7Wm7D0c=;
        b=vIjQ/O9UqIyRD+yDCgGfEkeq9VjQxIpSiroUkyTRcyv5OCeu4nOWCp9DOGsMQSCoc6
         WH93zaK6mg40ckl0PMmC45GGuXcKugmXby5Zb0F5Xe90/lTlkMASAYN+fmRoaIZ1GTY8
         eiVsSRsqhwET0ftq1RbqfSgwMVoG9TKhoGBJjTy/ImtoZjh+104Yc/FXAYpm0Gadhyd/
         LkV+sf4nKtHQY3kA3nqpF9zDmjcEyMFgSVCzu0omf1qP6lUUPoX7HpyUy+DTUCGPlS7a
         0sxFqObdheHy8Foq6Jk/68wOjt00Db0A6WBEwJuL2iKML4VQY4QoMCmU5kfdR6aauzVa
         Doxw==
X-Gm-Message-State: AOJu0Yz9m+lOlSl1gZHLI+BJzaSODBemRg+ZY0vyRrBUj9+mucktV2tE
	CjTwogvdY9cyA3RHfHbI/lDte4wUAjqkX3Pm1qc63ytf/WwNbgnyVEq6ZQ==
X-Google-Smtp-Source: AGHT+IG7InbVUntzwC4Lf9SsNmnSYVuBbskE47+1v9VNdzfKC3Td5ULi5HitVmbPo2SDv3T282kZ1Q==
X-Received: by 2002:a50:ab15:0:b0:56e:2493:e3c2 with SMTP id s21-20020a50ab15000000b0056e2493e3c2mr3683463edc.37.1713042079121;
        Sat, 13 Apr 2024 14:01:19 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7b4e:ed00:81c3:86f6:8077:78ae? (dynamic-2a01-0c22-7b4e-ed00-81c3-86f6-8077-78ae.c22.pool.telefonica.de. [2a01:c22:7b4e:ed00:81c3:86f6:8077:78ae])
        by smtp.googlemail.com with ESMTPSA id u12-20020a056402110c00b0056e51535a2esm2949664edv.82.2024.04.13.14.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 14:01:18 -0700 (PDT)
Message-ID: <5e01f46f-266f-4fb3-be8a-8cb9e566cd75@gmail.com>
Date: Sat, 13 Apr 2024 23:01:17 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: Constify pcibus_class
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Constify pcibus_class. All users take a const struct class * argument.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1325fbae2..4ec903291 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -95,7 +95,7 @@ static void release_pcibus_dev(struct device *dev)
 	kfree(pci_bus);
 }
 
-static struct class pcibus_class = {
+static const struct class pcibus_class = {
 	.name		= "pci_bus",
 	.dev_release	= &release_pcibus_dev,
 	.dev_groups	= pcibus_groups,
-- 
2.44.0


