Return-Path: <linux-pci+bounces-10324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86D8931C69
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 386E5B216F9
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 21:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE58113C673;
	Mon, 15 Jul 2024 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/LigJcr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D48513B5B6;
	Mon, 15 Jul 2024 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077788; cv=none; b=uU4RONrrrSh/2ogQHbNjQTxeJ/9Lu9a5QU5Q8ZF0ZsUvMnjBW8bpp8sGos7y2eqF6QuKEwFUQ5hS6F14AJ3BBZC4Fz9G47PNFmgPc8vCFLKJQx5zDNJxddleOjRVaCCopY0QQmVQ28Yg/ycoMvs7eewNc+ybjCxczqervFaMNjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077788; c=relaxed/simple;
	bh=MbZ1dCHqJ/442s6cosB+tD5mGa46VywcXhS+EVwsdz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbfqiBASNaOEd1/lEWC9GDO0fO13NVku+bD3jTEWhxC5VO/jL9j50AQDPbU9Lq1qQcM7XCCKCQQYcufJPIG7Hmmh3F6tB4tkg+CCUKl5g/u8SQ94Lef9er+oMbbTTe/5Hv6oXO12ZZY9msLaVL4+88IdAxiiEnyglzUJGgL/M2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/LigJcr; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44926081beaso28849661cf.3;
        Mon, 15 Jul 2024 14:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721077786; x=1721682586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y93QuD4cfjTuXNEsj0RS5pHXYmn6UrX+LGa4LQTALQo=;
        b=O/LigJcrLBjtUIbfE50ovshX24XJX+iOvoudV3jv593MLYTBuUgEbj8mniILvRwRTC
         0IHETdJ5+tVANWjGavq8qc3YPRRYdxu7FCZAp3XFWBpEPjn7QBMsf2+JttANCOjxKX1A
         gc5xRpL5q5Lv4Q41h1rYHP8Wi8CMC/ZYF/TWvJLWaxxyA+7NMiP32shVn7YWUzxkne0Z
         UJzxK+I99zIc0dMfKA9OJSokXvkf/7UKaCE0N5938BYsK5RpQ7BksWN9+fp6a1NTSDS+
         QVomMOLWOIBawML0RhfWXBsFnD2KaWaMQ0bA2Frmx6WiBshSEbquRBX3FeXWhXm24dj8
         l3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721077786; x=1721682586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y93QuD4cfjTuXNEsj0RS5pHXYmn6UrX+LGa4LQTALQo=;
        b=BUrx2PbrCfxMLkug1skniCQoKFx/xfRoPM3rC02To4tG2dJlapHYT4Iv34l4Ie/eaE
         0AgN2wal+N04BwCpfhrQtSTBIWtYFCFrc8xX4p4i8Q+7oHeaxFOfTZZWM81xZlg2WhEY
         GUkWfSp6oe4hCxpxc7oM3wyOsTD2mxIsZV1CjGwemXVHxyfgsgYp3CIkcRdqNsuNkNb/
         YVpl+V1G09tl6NeNdnlrR8MN8gOmGRA4JBGI3FEXwdXiuuRhRj2rsVTnn2blRdF1Xh93
         2OSr17r1s+rWpdpbo21MG4spv1Hui61u0YDxAZ/J5JsnF1b9Wpzc1A5MgGlLao6ddYtJ
         nQDg==
X-Forwarded-Encrypted: i=1; AJvYcCXgn/iDTYK/BRUjApLLUNWMLcDUsR9cRnq/Y9W9yQWLrHlhun636hFIAoIfukB2TaKymrzWAFY8dUJHgLA45TCbT7xpyUDt2goG7lmKp+hp+c9jxA55JDoacXT4rJrZjSsgOGJiOmhS
X-Gm-Message-State: AOJu0Yx+gTxq/aHhseHYqu+0JtxnnNiPiu+cuDkvNw1uSr81Qb2a2nyx
	7XsCGyAea2cn81rz9hOMN4NesRZ8YUBZfuqZ/sOjKQU6s3eFQRIL
X-Google-Smtp-Source: AGHT+IHJ+lIQSzH6maVbFUR9tEYSEk3oFiFHq6QFidXyxSrVvtZ3MjuCbSb2P7DfDLDMt6JTBzQnPA==
X-Received: by 2002:a05:6214:2585:b0:6b5:e44a:6b30 with SMTP id 6a1803df08f44-6b77f54fc4dmr4989216d6.47.1721077786228;
        Mon, 15 Jul 2024 14:09:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6b76194fe1bsm24807846d6.11.2024.07.15.14.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 14:09:44 -0700 (PDT)
Message-ID: <d8a3787c-d45c-4cf7-816e-6b59bd8cf3aa@gmail.com>
Date: Mon, 15 Jul 2024 14:09:41 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] PCI: brcmstb: Use swinit reset if available
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
 <20240710221630.29561-6-james.quinlan@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240710221630.29561-6-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 15:16, Jim Quinlan wrote:
> The 7712 SOC adds a software init reset device for the PCIe HW.
> If found in the DT node, use it.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


