Return-Path: <linux-pci+bounces-35483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731F7B4495B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 00:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C5D484982
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 22:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AEB2E7BB5;
	Thu,  4 Sep 2025 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FanVN3Eh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFFD2E7651
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024185; cv=none; b=aIcZmemimutqFapcVoP0D08Jg7RQ9QJiYuok7skwzIqBOVzJytTlPHeoyltxlKG6HHFt8C640n2Cqro9pkC5b/mdLJymnRl3Xl0xKm08BdHX4acP9hysYXBqzsQr8cLWapTooIDVhGefvUC4KIKyYLxHS1r3lknqTPtM2NqzbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024185; c=relaxed/simple;
	bh=+ZW26YkUajpJpxvZyQ7i4YKy8mdKix00cWusc9O7HQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GduTsZDmbh5o/q6TwUN9/3VCQbiy49G/QbiOLi8a8NshuhNaGQN0mT4AfGD8QWEbk0hICKWkj/ooC5ZIAZhruOxRI5Is5TCeOBdF5WadpkqKF8OIjLl+xRJ1kAwri3fpvG6fFasvg40sO6QGKQMfytV+vdPnw7QijXG0dYDilJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FanVN3Eh; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-772488c78bcso1534600b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2025 15:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757024182; x=1757628982;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XhlHQX9QZI2Wc/319mBhA+FHNIABCp68X6Q8ZJdJwTQ=;
        b=n1DIsszBiUP5vjDWggsFrxEt57LVz3nHOIzmGGS/jVWDMveVJMwaoTG2ku2wN95vnl
         V+jZhJt8i1OKXLSF8z84JXEnnllPBzO9pfYLoc4fLZBvY75/4ORLqOsuwJF9yf8cJi0z
         l1qB72jF9GAW30yxY6qzyaIDg5SMrGN5ErePbvHvVum+y43+5CjHn2+D77jY7A8rFdUA
         z4m+7+ub2q/uN0l0+Cl1/CKtH2NKLyhCywqdsaSMzCT3TiBjNTCxN7E7IA2j3IqFmREO
         w+rP/lTuJc60HaEu/xiPzhJ3BZ2ZvLpcj2v+mjMrrWECrAf3FBMzzkjMwrFjW98qYAYc
         ya6A==
X-Forwarded-Encrypted: i=1; AJvYcCUuM+SuhjJiQBZE5uA2Zza8qEF/3X8ZoKjUh47qoEarMV3+/patDjy3VUzCYi0fKslLG/glRQAW6sU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6aQW+qn4i5zqmlw1eetYIHBP7TvQnICFnaJw314rfuxOAcqYA
	QjhKpT1qgHrPlmMBu9JpYe0pt8YiYsbIEN7WqkF6ScVO2+ibY6bK6M+YJJ4R+EhDl1v9rwE/bHZ
	YvuRzgbcDsZc+Vu9t7OWAmEHU/9fY6yEP0s49GJYSR/DdIe3iN6/CdECLTrPkcefUcbbiVEN79R
	sxcHddDUgtZ0cMWyKaexb0snN1EzC2QDTWe07uxHq2kyw3vEdqIhk1JVe0vlLmfhb7AQBUC8l/1
	FCc2m0C4ef0FNKDW8BZ
X-Gm-Gg: ASbGncu7NIACcbd8Qr/82mfXzRDshTCGJD4/s2dSIhp801fS6015PWZmmRPMHcl7VNb
	cOGbcgJ35/fprpogLJvJHHDKTHBVmfOQLubveBgX+as5MWAZh2IuyRCkMJWUcxncRKhe6GMjivk
	rnd7sNk9eMb5RHyZ2bb092F1w8EQKSuXUcU0Ul/LfoV37Jygn1fCV5JniDKok+MIVQwqIkssZ0U
	YLKp/MBTO+uh/VeOi3LMwe6XK0FTlzpHyuf80M5Lu57mjq+d8M7USpUFn/bznGyw7vY1RqslTte
	NzeF5RUhrE8jond97mq67A8ipibjRRNSoJmUxXQ5B3fqlX4sByyydl9IOnz+qFB/gYuKnQIGCHM
	RTD/r9aVI+GjKFNE2QQzUZXlKlnIgTUApGxZpLD7IYiL3oKpChywAUI5SZChubeykiMP5sU6rV9
	PobaRRATQ=
X-Google-Smtp-Source: AGHT+IESSqy+iQX3N545X8RsS+judB8Da7J1Y/emmNcHxlUUU4GQzIXKgHrrYvJcgvx/d1PZFdaGFZwdhIOv
X-Received: by 2002:a05:6a00:2d86:b0:771:fdd9:efa0 with SMTP id d2e1a72fcca58-7723e36b457mr25242420b3a.15.1757024182389;
        Thu, 04 Sep 2025 15:16:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7722a316d4esm1253783b3a.6.2025.09.04.15.16.22
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Sep 2025 15:16:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-80593bfe0a1so253440685a.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2025 15:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757024181; x=1757628981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XhlHQX9QZI2Wc/319mBhA+FHNIABCp68X6Q8ZJdJwTQ=;
        b=FanVN3EhwuVCWPv2CsIMhcXELdo8UAVLomqWYZ0oyGNFrbzFUj4BLm85ql97h2q5U3
         YlmJ9A9jlOzpFWufJgkjXjY8FyacJplhbtWMns70nJAq6mtxBFOustP/k+sFvgTxQKDV
         JElpWCkTSRp+INwUHtm87Q5k2ymzNH4dqUAm8=
X-Forwarded-Encrypted: i=1; AJvYcCXQYX7cVXXc0vxFoXLULs8pxrgOsWHschbFXmP1MWhXjk2lK6BLoRPMw1kdTq30tA1KdoyrmtUZW1Q=@vger.kernel.org
X-Received: by 2002:a05:620a:2585:b0:7f2:d9d3:f5da with SMTP id af79cd13be357-7ff284b1c36mr2661083885a.33.1757024181125;
        Thu, 04 Sep 2025 15:16:21 -0700 (PDT)
X-Received: by 2002:a05:620a:2585:b0:7f2:d9d3:f5da with SMTP id af79cd13be357-7ff284b1c36mr2661077685a.33.1757024180578;
        Thu, 04 Sep 2025 15:16:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f7838edsm34678821cf.39.2025.09.04.15.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 15:16:19 -0700 (PDT)
Message-ID: <7e83777f-0912-4ae8-a196-d07fce67385c@broadcom.com>
Date: Thu, 4 Sep 2025 15:16:14 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/2] arm64: dts: broadcom: delete redundant pcie
 enablement nodes
To: Andrea della Porta <andrea.porta@suse.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
 Stefan Wahren <wahrenst@gmx.net>, Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 kernel-list@raspberrypi.com, Matthias Brugger <mbrugger@suse.com>,
 iivanov@suse.de, svarbanov@suse.de
References: <cover.1754914766.git.andrea.porta@suse.com>
 <2865b787d893fd1dcf816e1c96856711754d612d.1754914766.git.andrea.porta@suse.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <2865b787d893fd1dcf816e1c96856711754d612d.1754914766.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/11/25 07:12, Andrea della Porta wrote:
> The pcie1 and pcie2 override nodes to enable the respective peripherals are
> declared both in bcm2712-rpi-5-b.dts and bcm2712-rpi-5-b-ovl-rp1.dts, which
> makes those declared in the former file redundant.
> 
> Drop those redundant nodes from the board devicetree.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---

Applied to 
https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
-- 
Florian

