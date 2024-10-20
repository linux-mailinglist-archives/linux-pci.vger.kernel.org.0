Return-Path: <linux-pci+bounces-14928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A949A5789
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 01:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B23F281EC8
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 23:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ABC28689;
	Sun, 20 Oct 2024 23:55:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C032260C
	for <linux-pci@vger.kernel.org>; Sun, 20 Oct 2024 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729468538; cv=none; b=Q+M5KQq6rcR5s5c+Jc0/D9QGaB6GtoD1k7/m8wx488tj2Y+NPzuAmBZN38xMkgn7SkOWQgeuQMaMZXs/M9YJ7kxAmqqBFPcpM6pPoqXb4J9sWlW9eUncqKUqvbyHsIqAHkqTLAa1zpaCsOPHOTmlF/iNJLH0Hth92JvZivisgO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729468538; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFLAzOXTHPs2TspB0La05YolL7BfxmCToAboLRqnKUEkHKFLNqlV+aZJLfjNzQRV1ktzVbaFes/DONUQu/WFPjml/MbcrSIdgw6kJ884dNcf+PSesgj9FjlEAaIQLueXG9cP8AFoHgbLSRazgY/iGgfVplGsZcTnLwT4GcYrsaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431688d5127so14719795e9.0
        for <linux-pci@vger.kernel.org>; Sun, 20 Oct 2024 16:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729468535; x=1730073335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=a/eLabe08A1XiLfb4NEoEUr1Af4iSo1Mwd+CvPvN0IlUURwp6IXjkZug5WwtPP4pmz
         1S6dwCnwOUnczSptMFYdO9LpAu34zyz5ai5TPrnp0lYe0mhJ5bUMPwsdjUTFMcqYkeyD
         s6gyAB77yvagZkEFLXQ6cPc02wUdP9jD0M4h+cHMpvSVbtJZu631QTcUU0562+ZjO/K6
         QmkMggL0e7UeDT7Jyv4e4nutHFWqmTgWHDm5whJDT/czxZZmkbYbQDBFuNgOC4nFwC1M
         u1sxYApurEO//buh7t7WRWFb3d94CgwVGEs3AbjIH2iLt37DfEA5UxZ/Av2CZPseZ+d/
         Q8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUSXvg3hnI+3MeKETZkcB0aWpv1qyWOQ9o2aTLyWVyIc9n89RL33fXLDjZcRIOO+mVHfPDSUaQ2tBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSzrlDOE7vN3LB9dz5kDBvA068RETBnkknkeudyb+vzqJWBcU
	NPsArWD4f8e0nJS28RiWRymubBG68LTCcouADpk5Sx2yiXGG6oqd
X-Google-Smtp-Source: AGHT+IFyVFAv70h/AJr7FhoVOAEdezseZLdrbbHy0wgG8J5GYist9hhBZeIY90BpXIrVd9MEyxK+bg==
X-Received: by 2002:a05:600c:4687:b0:42c:de2f:da27 with SMTP id 5b1f17b1804b1-43161622809mr66747635e9.2.1729468534620;
        Sun, 20 Oct 2024 16:55:34 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c311bsm37978785e9.29.2024.10.20.16.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 16:55:34 -0700 (PDT)
Message-ID: <0e7ca790-e354-441c-881d-6b12bfc7a115@grimberg.me>
Date: Mon, 21 Oct 2024 02:55:32 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] nvmet: rename and move nvmet_get_log_page_len()
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241007044351.157912-1-dlemoal@kernel.org>
 <20241007044351.157912-2-dlemoal@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241007044351.157912-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

