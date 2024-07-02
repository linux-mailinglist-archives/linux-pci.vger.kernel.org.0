Return-Path: <linux-pci+bounces-9581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 428D1923A4A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 11:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7C26B229B4
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 09:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A0156F5B;
	Tue,  2 Jul 2024 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A0miFm+3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F0915217F
	for <linux-pci@vger.kernel.org>; Tue,  2 Jul 2024 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913180; cv=none; b=jDyaJD9jnHvNOMOkPr7uSPtqHz5+Hx9d6ChcYJgzqvSJaktBas1vMW5K6kD7E2QFSo3wsPiVovumgGcfqfPfp+cD5WrsOoPGxk/WleYjAxiG9DJ79rGogl6F3VJMjNknv7xrfJxvF11yiXUCqSV/UVPdJosU+qhCKsQ1iV0MluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913180; c=relaxed/simple;
	bh=f5aEQaGOfXIWPwTo1jSU1LMxGqsSJKtFgwK76UHJzk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFZW6IAWGOhpMHRIwiQnK723bCa9Fp24MUqRWj5mAU44u/lgjJgPoZKz7QxSuYbzNbIg0MZc985C85zH4JolDxqnSwqOPruT7SmIhGshNca++hZYO3GHGOEjX2uugjDe4zMbuW/98OBZo1JttqqjSo3IOZyXRA0P55n1kQ7+yoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A0miFm+3; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57cbc2a2496so1408484a12.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Jul 2024 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719913177; x=1720517977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08t6/yLozDZn4kBoH75KkbY5mjLhEGn74LBuGG/v9cc=;
        b=A0miFm+3ezpNTIFu+EbslB7ppR0dZu8oHEb4tmlCA4IdhbgFoO2+mCNcLEQ8zz1mK4
         u7q+ZvV72rl9TtlLJcAZtN4UyyV6sKBEMUnp8j9PYn0kiiR0kt1/iGYrQFpaeOhcmT0K
         NByOU6nvfzYT3+FhA69iIJdvCqml/3TmYaW6hkHXIAGzg6er82Du0WUw2sbSbtKfwR9Q
         iacpHQPEf2AkeJeAct2dQlY1uyFsSYVtiXix2yENUzD9Jb/S4btyGfAVaC2AtODevQqC
         xHMSEqFWInjUSNhxJAuu5Wbgo/DcNnXcSJdz2Z/MJvbnd8z8M0QP+S7hcHGRs0i8aWo4
         yJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913177; x=1720517977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08t6/yLozDZn4kBoH75KkbY5mjLhEGn74LBuGG/v9cc=;
        b=gWlE0O2TLVhu0dQFaPflwBPRoFO2Kjh53Fk1WmBsVnGTLVUgrpoKnTmtDZB2pIJQQ2
         zJtJ+UPtOLZyXmkUAxtUp/cJP1xcZgYokxbp+T0wAyM16D/RhTIuP96Xb+d0Q+nPgs7w
         ZlgAHWE+Mfv6hF5kgywSavgu7of8hsAaTIgTUmCWzkmZgdCwKhYcY8XyT1dEp56uFRAi
         EUOAhO5613WXRf5S0oRl5c/p3+DuHuwgwyPEL4GmUSLYMJWNgjAO4wkFSwTV7ReiXSuC
         mmjuhrgAP7y4FDtw5jNwp5RZyNCpdYxhGrVP/SpSMANnz4XiINrRyRja8b3Fe15Oitnv
         Y7ow==
X-Forwarded-Encrypted: i=1; AJvYcCWLpCSMdWbjVLMJr1S4WS+33djQLycYF1i49zTDM/nnt9ofKFriCDtq6VeoPJLkEzZnc6TqfSGu6I39RGTgLxvY2IR+Eo+a+rsa
X-Gm-Message-State: AOJu0YyfoxFgGyKAau0NKsNCZh7j7fwMXO6qFmPVuG7fmjhOQyx4iwDZ
	3MwqXPWIPtFgbnOJ1WaRuqCUtSYdjn+zqxzHCPGzZspVP2FbZV2eaWvhBj6vN0Y=
X-Google-Smtp-Source: AGHT+IF+0VvqoaZK4H0Ai/2Buh2/MXXAKhg716vK9ayi8LgqviMp/4trv0JhQg4YfvnIpmCvVYTRsQ==
X-Received: by 2002:a05:6402:1cc1:b0:57c:ad11:e759 with SMTP id 4fb4d7f45d1cf-587a0919633mr5285153a12.28.1719913177175;
        Tue, 02 Jul 2024 02:39:37 -0700 (PDT)
Received: from [192.168.1.16] (79-100-234-73.ip.btc-net.bg. [79.100.234.73])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614d50da0sm5463359a12.59.2024.07.02.02.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 02:39:36 -0700 (PDT)
Message-ID: <44ed5fe1-9c75-4b63-94f2-38a5b1817538@suse.com>
Date: Tue, 2 Jul 2024 12:39:34 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: interrupt-controller: Add bcm2712 MSI-X
 DT bindings
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20240626104544.14233-1-svarbanov@suse.de>
 <20240626104544.14233-2-svarbanov@suse.de>
 <baa71bf0-49af-49c1-93c4-a4c647ca0f94@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <stanimir.varbanov@suse.com>
In-Reply-To: <baa71bf0-49af-49c1-93c4-a4c647ca0f94@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Thank you for the review!

>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupt-controller
>> +  - "#interrupt-cells"
>> +  - msi-controller
> 
> From the implementation of the driver, it looks like all properties are
> required, except for brcm,msi-offset which has a fallback to the value 0.

Yes, correct. Will update in next revision.

~Stan

