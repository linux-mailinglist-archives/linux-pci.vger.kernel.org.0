Return-Path: <linux-pci+bounces-26341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1374EA956FD
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 22:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329701734F1
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 20:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839A91E7C16;
	Mon, 21 Apr 2025 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8FHD09p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88C2F3E
	for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2025 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745265893; cv=none; b=JpPk2+zpkyK285A07f22pFWGXazUKJSbVvzzlQKOE2mBlgrCTirPjvVnKJ9ZfiZdIdCAR7FXq8oQm5xaKbdClb5nRolJ7L/O4Iy1L7lxSX+CkeYSgyAWP1JOJXtAw+v7RkkkwK6qXJ7QuROEJ0+KsQF8s2FtnWY+WeO3AwFeqWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745265893; c=relaxed/simple;
	bh=pLsTp+FBhvkt+c3y3Fu9eWZpRzoI7MQXyMuPmFs53uM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=NIJeuXaPs3ggxuLEkdZ6HJ8m1vXjjn8LVX9bYcacYnhSkX/LtWs9qjDZP0mU82NQL1M9aljFO59SDVNqk6+sIBoZXHjDRPPsCZg/Ube6N/9dN/rbCg0QvAkfKqjr2e/zwa99PoOADBajQRkJAsHe8kI8HhcuJgal4R/9LPcD1x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8FHD09p; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-391342fc0b5so3612973f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2025 13:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745265890; x=1745870690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uv9+EIyszd7LIRtpIe5re+olLWwBk8cQv33DWJSMl8M=;
        b=f8FHD09phwpqF+VsLTAJG/hSQSSWJw3k2BGS7+jJ5G6TTQRIUHLiFAmgHdu++V4Vi9
         /lk+cJC926/WWXuSS+7urt7MZrFFotvbAnuHVKef53ToQPzuNkBeIwiHCwXGM9CWBOvW
         MAUcoIbkiSbTAoCCCdaWoC/p7e2vWlrCObj9UO13ii3KdOnL5l3zIixsh2CE2URN0Vl6
         1QUy1OkXnM0WxzTrIlrvLVZjKhShq3bvDG9qpIL/v6hLpXAPdMBivihwbvdcJIwVAYaA
         XE8xOkUurrVHtsx1o7YRCda5sOKuqCtsUCczdIwXVFZbtd5DVw4YhSpavKb3ac22qfSt
         RlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745265890; x=1745870690;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv9+EIyszd7LIRtpIe5re+olLWwBk8cQv33DWJSMl8M=;
        b=OuT1afijzXInTBNCizvIJclxXHsG8mCeshQjpTkdr8mGJgyCCMKm069VqzkRkw3DnP
         qm5nL4fjhb4LBmgRIyomsMXVvp+nkud8yWaGRVGsPbuqYZ+DBzcPMyAFZmRY+5DCa9hw
         zOPWOiQAoS6WWYyHtFwbzNnhpHbtGdbkkloMsZp7wLwsMvVSZGvgaWPbrh/FKj86IJx7
         pYscyv+imSS+xxUZhB2sOQk8qQjeUbnsG79KtJMkxH2tE0XtkgHwteNX4O61DU7T80Ia
         Twy8s+YeJdEHLp8udSnl7ruT1/Xz9uWSblI/lvLX+4Ep7S47DkVkjQqkJo25nxFgZ23+
         jYGw==
X-Gm-Message-State: AOJu0Yw+NmfBBsb1/Qa8rl8mW2EdWAYo4q7YCUBldA5gd2fG74GkbTZk
	28awddjAFp8kFLUjCKp4WcSxwjAo2P/U58R1FGymti8OzHCxJ1KB
X-Gm-Gg: ASbGncsGZVdvhy3SOK00rYJ/j5QlSKopAjQZ/be6QHJXt/Ckr1+SUhGlTgTJhF8DNMn
	IpvrKPWUHAD7fLZ2tNy+0SmQF8UCaxfvtB/Q2CcO59ypNNd4V68R3HKcOPZGYzYeOSMIB3kurdv
	zrQTUQWtbzPzv27Vbf3W5MELUA6igQnZpPeSUuQFbPvVdUBmL7QS+GEIA+KCOeTGaY07Rd0J15V
	BEurdtQgH5p0cNjdbacwPrulCCOLmG0t4bZ6BOuKz3pVfAUh8788ucnFUTo4xhdwyJsfUF20b9n
	D7QRzhQ9/SQRgbi2OdIG21P4Ex+INE9iOxtNRiHNMWHnLEmOgNzhbDspRmKy6+/um6WXQryzj4r
	+nNVZefMRPtnixCBaCGt8o2QTKkIZPbp1ipuIO6/U5crHxdJ4fEBOWDICzwCM2BOCXtRAJKn18+
	QxUZ4EKbpSMMIf8gWLPdEHTdyALoY5rGy/QJKIlUvy
X-Google-Smtp-Source: AGHT+IF9PYWQelxliDr1R9PdaV4KHU9gPlNjC8Te4u6XD0nCVej7eT8ZYdojDrTOc4VkwJ6yvTtUjw==
X-Received: by 2002:a05:6000:250f:b0:39e:f51d:9cf9 with SMTP id ffacd0b85a97d-39efbb01f56mr10093305f8f.48.1745265889868;
        Mon, 21 Apr 2025 13:04:49 -0700 (PDT)
Received: from ?IPV6:2a02:3100:adc9:f500:6d8b:3370:fae:2b2e? (dynamic-2a02-3100-adc9-f500-6d8b-3370-0fae-2b2e.310.pool.telefonica.de. [2a02:3100:adc9:f500:6d8b:3370:fae:2b2e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39efa4a4e93sm12967009f8f.99.2025.04.21.13.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 13:04:49 -0700 (PDT)
Message-ID: <62de9027-e4cd-4192-90e8-64f4c4a8fe4b@gmail.com>
Date: Mon, 21 Apr 2025 22:05:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Potential issue with pci_prepare_to_sleep if there's no platform
 support for D3cold transition
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

If there's no platform support for transition to D3cold, then
pci_set_power_state(dev, D3cold) still returns 0, even though
power state is transitioned to D3hot only. We called
pci_enable_wake(dev, D3cold, wakeup) before, therefore PME for
D3hot may not be enabled. Is this a bug?

Background:
In __pci_set_power_state we have the following:

error = pci_set_low_power_state(dev, PCI_D3hot, locked);
if (pci_platform_power_transition(dev, PCI_D3cold))
	return error;

The acpi_pci_set_power_state() stub returns -ENODEV.
Therefore, if error=0,  __pci_set_power_state() will
return 0 if pci_platform_power_transition() fails.


