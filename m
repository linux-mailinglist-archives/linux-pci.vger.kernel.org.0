Return-Path: <linux-pci+bounces-5425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBA889263B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 22:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2D5B21923
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 21:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EFD29D06;
	Fri, 29 Mar 2024 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbO9+mkh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D2D1E535
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748462; cv=none; b=VE6C40SXznWRVuq2Cl1VM1mndKwraE2iJ1HuhO6Hkw3TmqVmaY9nsajxkaTtdud2H6HRXvbfzbqDIBDyRplhQjvvQ2+omkMA+7DuRe+EmbJDjopgJCJsP+ebEzRW9k2Pvhz7xCSWPJkBrM7KzO4OsDncYB5II3OgqHQpWny/g0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748462; c=relaxed/simple;
	bh=Wu/4zUN6fo7l7u2Wyi4po7j0qwXlwid07I9QD8owjVo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=j1cemwOU3NvhfDCAbk1ogU8uVA9HeyTrKtkzoWGgqdNHMKOnCYuBAoArXAdbTokFqD2vD4uXDaIjZjcoF3vwCDo4f9SS+w4RN7PKnbfdjlCTabvn/RY5kt4hvIwCpObzU4/w3a+crmI28nAiD+qpJGi1BeisShPWGLUdqUXj0Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbO9+mkh; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51588f70d2dso2815899e87.3
        for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711748459; x=1712353259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEavmMnwLilIGDdkvLLt0eQ1OCXa8c0i4pI9B19Zeuc=;
        b=IbO9+mkhwe1KpoOipvzy0dHr8xI65dLrpbGmYfZBg4QUNvw91nKFORi8h8q3qt9thW
         LhQl5NyXsnUJ4kmgAaleNEsONJ9HaVuhykJIY9JPGCZqardXpBnZcKoVe2/3f7WZAQGk
         zl067/34dctCtzsUjZ0vkstYawfk1YM/OfAssHmX7h20OXsrpeeK7OKdmuXVaxtOgNWd
         IO/4e2bh0LN1p9GhX+oOTRr2PWt+yXzZKXH/WCi9TWW39F2irc+583P42U4eEVovt01v
         HN5nduZO5MBrBolLeXZRRid6Gyv4VXn05FU2XGvrP785jsfdAaKw4tY0m39OozTlTeqs
         F68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711748459; x=1712353259;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEavmMnwLilIGDdkvLLt0eQ1OCXa8c0i4pI9B19Zeuc=;
        b=hooDjK78y7MPDkgW7VYhPjlSxBFOP+2Q26lYknewrxzddSEcOs2vZXiq+a3/Z825S5
         hL2yC5ZNhECIFz0SzJFNE/CFgCQRcPSE3ElA2cccpVCXW/mKYFc3skTmJY0E637/oILl
         e4e++dziH9dH13n04LuqYkj2bl7W/7QLa/o9y/bcxSW6UZt++SegUbmdO2G8R01DeXzp
         FzmETEcv5yLPVrXdiHnYTgEi0gfGHc+W//39zNtF8y5xCMz15Oel53IE5vMdb/rx4MH8
         Vnr9QihhqIypXDuDsZT8laHtQ9Iefo3lCOyEbLnC+Yxkt+e13m8QsfyUZMP1jQ7Pgbam
         x08A==
X-Gm-Message-State: AOJu0YxxjEjsqSPrCmPfZ6y1PzzPWGX3jnGf8+i9Adsf4yPNrBYQ5z+r
	VRLQNnVjxMi5bhbgCmVH2E5a2X23cyEeu0hXdFMIy/o054x2LI1K
X-Google-Smtp-Source: AGHT+IE/tPMKqRjtYl+lTfaXs4S04E4bUTHdPYB6E5Aj42ePoEHWaiM5KLXldEN9QhTEBMpm7RV7Sw==
X-Received: by 2002:a05:6512:4848:b0:515:d1b9:3066 with SMTP id ep8-20020a056512484800b00515d1b93066mr1558976lfb.46.1711748458777;
        Fri, 29 Mar 2024 14:40:58 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7bbd:b600:50f7:b974:760:86c8? (dynamic-2a01-0c22-7bbd-b600-50f7-b974-0760-86c8.c22.pool.telefonica.de. [2a01:c22:7bbd:b600:50f7:b974:760:86c8])
        by smtp.googlemail.com with ESMTPSA id gt14-20020a170906f20e00b00a462e166b9bsm2360805ejb.112.2024.03.29.14.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 14:40:58 -0700 (PDT)
Message-ID: <cb48fd68-9bfa-45b7-ac4f-d1c2b9b1f207@gmail.com>
Date: Fri, 29 Mar 2024 22:40:57 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RFC 0/2] PCI: Restore original PCI_COMMAND value in
 pcim_release
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Philipp Stanner <pstanner@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Philipp's series refactors bigger parts of PCI devres. To reduce
complexity of the series it may be good to simplify the current
devres handling as much as possible first.

The patches proposed in my series allow to remove the MVI and INTX
related member from struct pci_devres.

If Philipp's patches allow to remove the region handling from
pcim_release(), and flag pinned is moved to struct pci_dev, then
I think we can completely get rid of struct pci_devres.

Heiner Kallweit (2):
  PCI: Restore original PCI_COMMAND value in pcim_release
  PCI: Remove MWI and INTX related members from struct pci_devres

 drivers/pci/devres.c | 15 ++-------------
 drivers/pci/pci.c    | 11 +----------
 drivers/pci/pci.h    |  3 ---
 drivers/pci/probe.c  |  3 +++
 include/linux/pci.h  |  1 +
 5 files changed, 7 insertions(+), 26 deletions(-)

-- 
2.44.0

