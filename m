Return-Path: <linux-pci+bounces-5032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B512E8879A0
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 18:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D592D1C20AF3
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 17:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCD845029;
	Sat, 23 Mar 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFpGoJ3s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761142940B;
	Sat, 23 Mar 2024 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711214027; cv=none; b=hFMJ+nSjc1VUFQ+sgcoDmzUcBKZHVsq012F1PJCVobRoiRwP02ZRzupgjfhI4cn5KJGbxmL42OGSBeuivlvtnIdx43L3JoHIcUR7nunaHL00CNBc5dL8IX9FHB/pDAkEhG3DMEEkSdmihPLmNjLPMzD1Zk8MmS6sm0aMWg9nq/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711214027; c=relaxed/simple;
	bh=PxKIofZrWqBFUcM6t4e3kShaErF3e90raCB2xpAlbBc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=K1G0ONuT9noCTQnqPP6svp1hYMrXEGXHPAmiDwKh/WtGKCoyggcY4wDXA5MvNt7NZDrFR0ZDf+wZJ16MobIij42uEinZPYCmu6tCATMC9e2lrZghAP1tkw54Kppl/qbumjmg4LUzBQuKf9bUZxmIPKB8rN+Ka1tBlMJNYyr4Bxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFpGoJ3s; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56ba6c83805so3678156a12.0;
        Sat, 23 Mar 2024 10:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711214024; x=1711818824; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYgu3uaeGW2h2Z9AQf5DvW+0tjZIJEj/QOPLPY44QMY=;
        b=QFpGoJ3srtiutaJXyXo5suItukJOykJrZhuDvzBgvsyU9gzCtPuVd00J2wVYRj0a0Y
         Y6eq2jdJUOEStSLvtYyXXpxaj3PWAEGbOrxZiJLLBp6omV969r68Inn/ZGAfC3jcnHDr
         N+kBBrwHmdC2dIwvzQneaoGx03bTnhqStHM5YOzG2bNWKfv9DxX3dEXxvUew+zeqftgs
         jnDia7gZETjwxrv1Uk1lBblk6vXNJCNbSxqsB1+S5QHQCJs2UC/3kWsyNgaXApqdmOrn
         RjXS/YVuy4qDi28Zni/Qs4SoN+tiDdA0Tj6T9z6p8iGEa2BYtGa6CNEY/rU1ZLt/cxpS
         2X/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711214024; x=1711818824;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYgu3uaeGW2h2Z9AQf5DvW+0tjZIJEj/QOPLPY44QMY=;
        b=KSqX24vkVBYGHroDa9/L+Q9XAxaFqOHaBlZ/AssEzEC+Cbg7LpiaXf9Re91ll1WPmV
         eeLmI3OuoFBlIXcc4mzOlS1IxFgXe2A0r1cwCTiWdXIqQeFm70TERBm/w2wVv9ww2rQh
         R15zvfgWJ2p7kaTCOn5sY27FeDN5IN5fJ+m978Q/leDpeHyj0ycfUpfkyZjvTE/rqRE0
         q+npy6DRgFob4k4c0myHCcqPhiSaE+zQK3N15RgCE5SRq0xhw1HsPpyO/OkYeduG/aOz
         317ez3Ei/r7+jMn5Ig/akzvtj7C/Ra1ya5UWlc+HqWwClMmf4Obib9ocWzdiG1Ry2R+T
         n1uA==
X-Forwarded-Encrypted: i=1; AJvYcCVLfvmhBrMCeUPwkXln8SY50qDWtPZucePBM5QIdRVY+4bKkHxAffA6YL3L7hLVXkMAnK9iKNqggDlzORteO5YCR5eWV1uJByw0
X-Gm-Message-State: AOJu0YwzeiLhYo6Ig4gPDhTboQt9KXvUr4KXsQ3uqC/6CQN6lzLv7Dmt
	GzbivuRymGpMcGcfRqhxzqrNvB4pjvTmIfS9ssTPwK6ZDyP3x6Ss
X-Google-Smtp-Source: AGHT+IHqJAkIrzHxf+e0CwZ/ud+YkOI2FdiA1ehbJ40nk9KxQXoKgY4p+88PRVm4RrWADsR5E/k/zw==
X-Received: by 2002:a50:d716:0:b0:56b:c32b:2dd1 with SMTP id t22-20020a50d716000000b0056bc32b2dd1mr1842057edi.33.1711214023501;
        Sat, 23 Mar 2024 10:13:43 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc38:af00:d7:3466:9e54:a813? (dynamic-2a01-0c23-bc38-af00-00d7-3466-9e54-a813.c23.pool.telefonica.de. [2a01:c23:bc38:af00:d7:3466:9e54:a813])
        by smtp.googlemail.com with ESMTPSA id d13-20020a056402400d00b0056be1339ff3sm1074095eda.41.2024.03.23.10.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 10:13:42 -0700 (PDT)
Message-ID: <370ff61c-1ae0-41ca-95fc-6c45e1b8791d@gmail.com>
Date: Sat, 23 Mar 2024 18:13:41 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-ide@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/2] PCI: Remove pci_enable_device_io()
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

The call to pci_enable_device_io() in cs5520 isn't needed and can be
removed. This was the last user, so the function itself can be removed
afterwards.

I'd propose to apply the series through the PCI tree.

Heiner Kallweit (2):
  ata: pata_cs5520: Remove not needed call to pci_enable_device_io
  PCI: Remove pci_enable_device_io()

 drivers/ata/pata_cs5520.c |  6 ------
 drivers/pci/pci.c         | 14 --------------
 include/linux/pci.h       |  1 -
 3 files changed, 21 deletions(-)

-- 
2.44.0


