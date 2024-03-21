Return-Path: <linux-pci+bounces-4967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AE9881C81
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 07:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E971C2099C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 06:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F343C460;
	Thu, 21 Mar 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqL19OBu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE63BB4F
	for <linux-pci@vger.kernel.org>; Thu, 21 Mar 2024 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711002751; cv=none; b=JmTcJPajZRgqJDWc8NwH67XDBX2Vk7WVSK0o7TIvsSiYVuZaXxsxwpJwRTI0waOgWiFGNkjusr9w3sptl7epbdGCPiVuLn2u5BoROa55WFr+1El5HNKTb54lJzWVaS177/cH+AkelLcBGS94+x/L4bzHyvmCtRDKLZfj8nJ99Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711002751; c=relaxed/simple;
	bh=IWzoRyiIq34RmhOn0iDV7qym3hPufd8Mn7S0DjBmBYA=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=CD0o9uOQ1FNIi1R4FAWAt6IXUau6i5CiJWF3R4gOFz5z+mKL45YnmatBeeG+egBX3AeZw1NSHltVOOckCLqxhZftwOQnFC4V4t0SYYpuvaGkWevhd2Yu+33ufEyeqFxA0qVPm3LCxCyOx4Jv7cVBSvhiDUvef4hyHTV3jGye7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqL19OBu; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e74aa08d15so484295b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 23:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711002749; x=1711607549; darn=vger.kernel.org;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUEt2Z97b8lEWwJktqHAAwXS3vj2uI9IohvvSbiYwx0=;
        b=cqL19OBu4XfvJOVHnWVyFiK6G+UNWEaDWLr0KR5GJNO7vY/5kNcqbSFj2ILU2lmo8s
         P40ZlnqUkMZonVX0SpC88NkgjxQx26gWxx84DuhUauvZBuzde95eyMMe7QCdClTg4FNa
         fAqD2fqzgkksgnc/cv+Gds55GLeoRz3c8P53ORigEj55L3/ZmYLSe+IYWxbS9CtXexIc
         i/rA6/e6j/AMQGowgK/u8DBAOdVWcW6l4E3FVlJZ+TtJ21d67uK860SSLoFFXMa4PD9D
         IJqYQL9Sq8+3c0nEvRM/uH08vO0V/DE/dCmyDu97sldq1Jo785/oEFi7NAyjYsDVTGpX
         L/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711002749; x=1711607549;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pUEt2Z97b8lEWwJktqHAAwXS3vj2uI9IohvvSbiYwx0=;
        b=qJo/+DXFGybAcALuPxcBQNVt8/rXveJ0A1CajZAtvdBm2hC3kzCzvRfuDNZ4G7giPi
         Sjbj+4ChVheO0fNLegylDjW+9GVItnZo6zalafom5+wtVK8wyxjpTt6w8Y1Iqn86gn4P
         tweedPAaucHAQqxz0pz5fej7zD/xPAmIoqJGJnXhl3y/muhEfN15JRXNgmWjlZ09/5rk
         yq3pcGjC22O2BuCxko0jc0SGekrbv8lWkWjFi2nePiNB/hw/UBgrchj2xZ0lxovs2uVi
         MeqQDeRBAvV3vjALfRMMIVsGRrwETDHANeoQ8Br/USYNEkcOoglhDgGWR4H0+1aSp7t7
         CAyQ==
X-Gm-Message-State: AOJu0YzaKZmEg+0UGeg2977cleSEd8iSBidzVJmz1v5zywYNtSUAA9yh
	ldcotFio6z2/9GsPqeyoP8hhrvGd/Crfvv+VFaHS6MOZwyWOF6fW/qxjspwq
X-Google-Smtp-Source: AGHT+IFFh0B7rRQW/YlGkt+nY/1iGfqTPKfLqWWVZK97B1ocNOxSXfwDtwugkA9lhF2LqUnAwwhPqw==
X-Received: by 2002:a17:903:447:b0:1e0:1a69:b000 with SMTP id iw7-20020a170903044700b001e01a69b000mr6526606plb.46.1711002749067;
        Wed, 20 Mar 2024 23:32:29 -0700 (PDT)
Received: from ?IPv6:2409:4063:6c85:f395:d58f:6b15:5165:7028? ([2409:4063:6c85:f395:d58f:6b15:5165:7028])
        by smtp.gmail.com with ESMTPSA id u16-20020a1709026e1000b001e0410bfccasm5392951plk.126.2024.03.20.23.32.27
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 23:32:28 -0700 (PDT)
Reply-To: businesssolutionsrocks23@gmail.com
From: Raju Kumar <rajukumarkorav@gmail.com>
To: linux-pci@vger.kernel.org
Subject: RE:Mobile App Development || Web App Development
Message-ID: <d06803c5-6c5a-fa50-4584-292308cde4c6@gmail.com>
Date: Thu, 21 Mar 2024 12:02:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB

Hi,

Just checking with you if you got a chance to see my previous email.

Please let us know if you have MOBILE APP or WEB APP DEVELOPMENT 
requirements; we can schedule a quick call to discuss further in detail.

Kindly suggest a good time to connect also best number to reach you.

Thank you
Raju Kumar

  On Tuesday 28 November 2023 5:43 PM, Raju Kumar wrote:


Hi,

We are a leading IT & Non-IT Staffing services company.
We design and develop web and mobile applications for our clients 
worldwide, focusing on outstanding user experience.

We help companies leverage technological capabilities by developing 
cutting-edge mobile applications with excellent UX (User Experience) 
across multiple platforms.

iOS App Development
Android App Development
Cross-platform App Development
Web App Development

Can we schedule a quick call with one of senior consultants so we can 
discuss this further in detail?
Please suggest a day and time and also share the best number to reach you.

Thank you
Raju Kumar

