Return-Path: <linux-pci+bounces-31551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0020DAF9B1F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 21:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F335A382B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 19:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D343D1D516C;
	Fri,  4 Jul 2025 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PANiQnV/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D372634;
	Fri,  4 Jul 2025 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751657429; cv=none; b=iaTqUH0ReV11iRuorbAs/2uOmI0ffoTK/5Z/8tkZBAF63aDlSfKMk4WMSWCo3R3QRCDt25A7PV79Ny5dUFYKlsQOCqbnOuPYbMtlSUNnIbdGftUww0c6GUo2ODVz+38zL2K0JZDU5Oe99dMP2hm45t8UCSN3coasZ3IrR/t4aGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751657429; c=relaxed/simple;
	bh=6YeMduycNr0ucx71qBoH/BU6xLYTkm+mYjA1vKxf/iU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Zm8AUmCJRvUA/Mnn/Ks9WWdA5IRAj5s9jMAGQhKU573x6e8qb3Rxth0+VXbOrw6yqH2Cw+A7Qn7g8B9nZkz7svjNFJB5qvAdai9xvSpDM7Olz1o+T1SXlcplCBtKrXWd4M6rYYfOiHGJTWfufUxcoUEyvttGFHTrPIONO/GrAh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PANiQnV/; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-23526264386so12102955ad.2;
        Fri, 04 Jul 2025 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751657428; x=1752262228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6YeMduycNr0ucx71qBoH/BU6xLYTkm+mYjA1vKxf/iU=;
        b=PANiQnV/UgGf/yXtYj426M+SxFh7CdedL52RjTldB7HqEhPKCpAkefMiYIDnHW+1tl
         xwvWU+SKT8kVdwa0A0DNcMojXFej5ywzMlzutjPw1ofhv8jPYGYJGS8/lzJgBPUTqWaw
         ciNUkw9H9grC29jAf3c0VuxB+WthZCE5rPnT3iMIWVI5G6NbZ6Y9bDF5iMds9B3XBu6g
         lkRhKPV3Pc8NJxntfdHOgNRiGnKCFqLLXgbQeYjQa07RE0o2PEvRVrnJvj2zJkShd+UC
         2B0CZgm5gY0Eb/D2Vn4QGU7kbO5yMk2W6R7b+4/NyFTHDAijHK0IuWhqxQPAbXKsInsE
         9T1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751657428; x=1752262228;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6YeMduycNr0ucx71qBoH/BU6xLYTkm+mYjA1vKxf/iU=;
        b=O74e1eOrcPrQM7xuHxPGYMa/uLJf4IiIki3doB0YyY+hnFbAMaCVPUWUmeZpqTnaFt
         TQyM7FQOBgXSKt+aCS/0ZAGS3m/LqL1wQBimvHQxyG8bI9vcmKDds4lx1zFcWkvDJvQO
         AtgBO64nvI7uOE6tYMjeTWkYS758XaBZXQymbqWSG5zYQNtJivztkZvgEFXXGGkbtw7X
         YN1lKiqlsOabHAvVrALuZulbmopNaCAizCoW6iQPyncgJoY3bCFX6O8O6FDWp9o6knZ4
         d0v+T1BpWbRTvSxl5zSG+wYDfG2lv5jQew14q2d+KpdM7y3tjR++MWSFdlKzee7h2zR0
         mQHg==
X-Forwarded-Encrypted: i=1; AJvYcCVOZeugKWwT+OrVWIGuDL+o8pRYy1Du5kF7at8YfJxlmzTaXP7hWcRMb0yUg1KHGVPB5lM2kZIxTfWs@vger.kernel.org, AJvYcCVsJnMSp9DZIdW23DtNMeNjo1y8SvUybvyl5j/O+ksm1FEjxY4J2ZlROuBmsH3UGNJBHE4Q2y/S@vger.kernel.org, AJvYcCWDZM/Q/woxVvXBFvFByJHvD4SAFOc1AnMY9HxYYrEqQyL/l9kG0VuLcHJYrrjpsU/2YDj3gsElyqsEQEgOZSM=@vger.kernel.org, AJvYcCWTCEi3N+JPl0zXQJM4fzmfu7buAA/9+XlOrSBDxJpHdB3WTp2zeN/DKpTi7k1jI9ijnpWi2f2a9RQ7@vger.kernel.org
X-Gm-Message-State: AOJu0YznPIkd6bk3Ta84tEL/T3j6gC91ptigO1LcHAnFmOsRWEV/5uLs
	rbAGfY+nRxY/uUMfIzT6Qeo2NVhFdik3N4w+XbEni+/9h0HebimZWJPZ
X-Gm-Gg: ASbGncumDzch3qVvat8rR4AEaGBtC4dOywTpAtOW549dsWIqz0a1sQUNKDovgIBgAl5
	r0jNV2IZEZ9QyhjxJGUTm4T9RW/0TyxUgnief2ZRpxpbUx5Cy/GDyr2udNFNofYgPTWcBYaBGt/
	99qWjG1yhn9d9hLZQqJOrrmL7ED43YXox5PvK9AM0Hu7xPVG9gOSgdVkwkDtJbYcPhTH6MUtKWC
	Mp+GOtDXzBhMjG0e7HyqsPwddXdIOwA210dKBSh+b6lQp2zI7KrrKzuwIVDL/gCqigxvrr1eLeU
	0kwgZlAELE5msiCTa+IRAZ93dLJ7OVNbX1NH9pORuwez+bf2gMJn5+UpjCLHYEcXs7E2GfSAyA1
	cfJGYpXxDhdaeCQ==
X-Google-Smtp-Source: AGHT+IFk6QKQkW35P7FONxRvG31BHVykVFqw4PTl1hx8QxKZED0AtutT4llwQsSg6/TFW1FvopSL5g==
X-Received: by 2002:a17:902:d511:b0:237:ed38:a5b3 with SMTP id d9443c01a7336-23c8746d7eamr45141015ad.8.1751657427664;
        Fri, 04 Jul 2025 12:30:27 -0700 (PDT)
Received: from [127.0.0.1] ([116.206.223.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8419269dsm25587255ad.0.2025.07.04.12.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 12:30:27 -0700 (PDT)
Date: Sat, 05 Jul 2025 01:00:23 +0530
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_Instability_in_ALL_stable_an?=
 =?US-ASCII?Q?d_LTS_distro_kernels_=28IRQ_=2316_be?=
 =?US-ASCII?Q?ing_disabled=2C_PCIe_bus_errors=2C_a?=
 =?US-ASCII?Q?th10k=5Fpci=29_in_Dell_Inspiron_5567?=
User-Agent: Thunderbird for Android
In-Reply-To: <3214E8BE-0A5D-40E7-A4DC-C1027CD052EC@gmail.com>
References: <CAEmM+Qi-Waxk5qcR+nfip-QGXaKk0-Kq7QSq890e9oYOPjW+bA@mail.gmail.com> <20250625202014.GA1585022@bhelgaas> <CAEmM+Qg+xxMfXb=704OfwYLou7Mh_BNaTevLaGfiG2peZotJoA@mail.gmail.com> <E8A26FD9-13E3-474A-87FF-ED8D27A1F27B@gmail.com> <3214E8BE-0A5D-40E7-A4DC-C1027CD052EC@gmail.com>
Message-ID: <B0A6D9B4-086F-4D58-8284-485B9FF4B31A@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everyone,

Here after a week=2E I did my research=2E

I talked to some folks on IRC and the glaring issue was basically this:=20

> [ 1146=2E810055] pcieport 0000:00:1c=2E0: AER: Uncorrectable (Fatal) err=
or message received from 0000:01:00=2E0

This basically means that the root port (that 1c thing written with colons=
) of PCIe is the main problem here=2E=20

One particular note: this issue can be reproduced on the models of this sa=
me laptop=2E Therefore, this happens in most if not all of the laptops of t=
he same model=2E

For starters, the root port basically manages the communication between th=
e CPU and the device=2E Now, this root port itself is reporting fatal error=
s=2E

This is not a Wi-Fi error, but something deeper=2E=20

Any tips on what to do?

Bandhan

