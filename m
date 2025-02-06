Return-Path: <linux-pci+bounces-20791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E530A2A7C2
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 12:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA637166741
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 11:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D33D22ACF1;
	Thu,  6 Feb 2025 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="a7ReaMBs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3122F395;
	Thu,  6 Feb 2025 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842066; cv=none; b=crj1eTrE3itog/w4Bgopkhu69VGwiZYDl9miNQEV5Hu8FgchiF3q4TVsbilmq98pSFe2WrpA9ExYhTcX+9k41fkKFKcXs5sO5KU7XhlACHUs4aaL5vQXER5rGb3G35CR+sHuW5FRDN3sOr/P9OGhl+1JKqwhQT9PTEfhVLWoCsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842066; c=relaxed/simple;
	bh=1E6Hu2C7qFiD2//pufJW1Q2YD753Bi9yu4ZCmW59VfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcdnqX6PwOaliRuPOEfDBshRzMOybDwPqGgcgS+Tw1xa9/KBAOejvSFvSUYN5Z8xAQxGUYuWr6tLk6EvjCMvs1dxMDTNt6+kYuoI8gEoHhx+7EyXhFBDf8JRXIKmxa9diD3rqzDe+0eP++/NfXSpeHD0sGWejiflQ69mRiElcjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=a7ReaMBs; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738842055; x=1739446855; i=markus.elfring@web.de;
	bh=1E6Hu2C7qFiD2//pufJW1Q2YD753Bi9yu4ZCmW59VfE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=a7ReaMBshILFjP2WttcxDdzbKHtAyQbCQHBuc7oFyuoYi1BFbGkTOvEz1XpCn06S
	 tJGt02+VgHiym6hI3FJLnDixLPxnqv3yevI5sZkIOEEM0ZpNs7fuPWa8xjs/PI23G
	 kUQTcq/sbXMeyTMM410HzzWkHfV13fltv1Y1W6Ic5pDw14twszr+Bk6QL3IFYSTgm
	 bHxJNZwVLgb3Ds3Wuzh216fG6jqgegv4mWWYpqZ+sv1wduXULts3E9qH7AGMY+yCY
	 XLu14YG/skTzkJBoozpk+dkXhxt+lF/t2zizh89jgRqYrw/+KHXNlmCqGwNLJZHL9
	 LXUVu6lGFnGFf835CA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.8]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWi5i-1tvTmZ0YSe-00OuzO; Thu, 06
 Feb 2025 12:40:55 +0100
Message-ID: <01a579e0-4a5d-4cdf-9ac4-7e6212279bd0@web.de>
Date: Thu, 6 Feb 2025 12:40:44 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [1/2] PCI/portdrv: Add necessary delay for disabling hotplug
 events
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, rafael.j.wysocki@intel.com
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
 <b6f97a22-4b24-4ca1-b9e9-38a4b0e69f04@web.de>
 <Z6Qho7k_zj7NcA37@U-2FWC9VHC-2323.local>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Z6Qho7k_zj7NcA37@U-2FWC9VHC-2323.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vwIx6WZB8R6dl55f2heNMfRVoYATPT7R1IS6ntgBXkGEPhZa54V
 nSPepfwgF4Px8hM+lcnfxl713zXUMGrL0KYCe9SJEd5SU9AR1nI3hEBXnHgh3sZAEuUZDj+
 GABKrPsURhBvH94sFjMCCpb9nN+l8LduHgaGxTiD3s/b1JNIbNvLanzk8PbVa3eHnD2RGa5
 lsoR6XgPNE5Kobv5nPuvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zkez2vHVfS8=;CZsYkPeLXtY6ZX5lA5o62iaUr+D
 EpydLBbLXvd8OpRvPiPGVL3jZKjgUvp6QjBjCZOdG2GB4rBeJoe/y4NrMB3+orJDBiQbMRx2j
 UPSYcdP4aTDv+4ettOMdtE7tu4Y8l64E0pAZoxu7eZ/n3iLT7xmNB+ZLn1amTxT1h+Zrejqhu
 w5ncsz7g9SO23b49TtOC6qC/JsOPh7bwWgKOwGSaTr2uhzSfLOYoybVwEqeDVwxpbjPh6C1lt
 zPv0IEIDCamdZIzrYeek5IzRgOtr/Ysi7O0UvBpZVHy1mXwSXqNjMHQSeVWw41bQKldSGZ0Us
 vNaRojLS7tz009j8Eyu59YtQUytMEP6gUwWugGBqtK/tWnGraplvodwvDnXjku0ohaS5J7htW
 zY0eXefFw3q/lA88H1h4nMFSvm3strafIePkYsomNV9WNfA4/3pG5lrc6k2Bpu1Gwj+hf9Kdq
 vKE/BkPMM2sDNtq2eROVjbr/nFeAgBxoLM0ZiAX8L6UsdoIuWo2jwBINyvr53tubr//arsRai
 dqmf0WmW4+Ln/6macbJZbIONG2e3kBftmeCNFtoeB6f+82BSTi/OTDXwjNhq3JfdkrK7JiRv2
 6IkQZ/carUxqxiZ8ZOCF9dlxuNFs95VDa1RBHjUfHjQzjy6PJys8mQY2NRtsJepbjD4d951am
 vIL8tIvSH76LmpVfZSBj3e44WG9jTru1qdXPEmucIXjD3fsDwwPJhjH0PIM9pCbE/A/fHaoAy
 X9UcYZyCD9be3l8/YtAPbl7DsJTbVENh+/PPdF3gji7QWIUm4ui95ZTFsL7QhUuaKbB80G50w
 txMB0IiLDcazabJiK2zVlxQVY7bYfJyhvE7xQXM33UuWLmm5c7pyKo+L71Z8uMzLrQQyTiJlu
 bREFgv+ufDM+b25HyJA45s+c17sYhydMvwEm0Y2fm1Oz/YoSPMVjRKDzGXPEM9HWL9hUjUzjR
 ku7t1BlOG/YlZNxvd+gS1IJEOE4CMT7xCMiV9X5qSNK0PQT2lhOjJxxT1T3X28c+kejiKt04l
 Ze7GJXz9jmRtcjmuGNb9lQpkT+mJMFRRTnQCI5eZrsrkg/E6JV4o/0ErIfxOQdZYVVmYjDZzc
 uoUkCMxbe1ef/W4i9E9N7nJYy3hSy/cXg9IfJhBukWfYU+Rr7HfwlPqT7RlSINL7Rj/eKGMfN
 DkZeeHkCN3bUjiN7zmlvfi2trf5ua5gBZxGbuleaXD7e8ZzMuWucC9HrShELKj5txRTMyeBOO
 FUYgsvRfV8umo7ytdEb6LvN0JNp+MMa33k1xwR3Npe4YMHsZ4U/Cd5PoYryeB/kxqzVxsQm1K
 KZoxbB9SRfFcgDG56KXReDtZCqRreHRtRWOvHEBI5g45aZKf6WAXqcxJGZSI+6hDpRNp1F2+9
 6X2nGI+5FgM6Ehhhqts/feoTqMhXKnQiYHZQ9Posdsgae0FGmKYHe11OPPxstSXmXSFnoPAj6
 EdF6oVQ==

> Could you be more specific? I got the mail addresses from get_maintainers.pl.
Would you like to take another look at information also according to Jonathan Cameron
(for example in your patch recipient list)?

Regards,
Markus

