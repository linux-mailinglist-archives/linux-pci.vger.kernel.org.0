Return-Path: <linux-pci+bounces-20771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3D1A297F3
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 18:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840321620A1
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 17:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0862A1F8908;
	Wed,  5 Feb 2025 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KToc3Ji9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908A1FBEBF;
	Wed,  5 Feb 2025 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777739; cv=none; b=arK0GVSdrLkxO5p95kHcu+dGiSfkhcORrlaAZLnQgk9LPdlYPzeVt6UUxfXvBM5qsTr2QMae/GPqUGZICU8HfFfFcjro1u3RH60CVSOk10DIEgGO6TrEO1DH6k6GSGf6uMan+IFiW3f4gwNfPRuh/V+3HhmmOnf0wxPsdyfow0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777739; c=relaxed/simple;
	bh=2wGvyYMnVgwfZDd+X3Vz5ct1HNuTyg4x337XNUZTx1A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=CkUQ1mz6hGqemC1NK6/VD63H6qJkeQeO2obnw3bWgHtUS5ybtjWeIiYIvhJok1B7TrmllY2diUqKDJMgTIfKqJZMEVkVAD+jw3P0YMsbCfqemnOUVtPHMqHBFGutn1dShvouxc/9wJXbaLe7fpltQIaNuZr1Om8tH9X1zjsUcQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KToc3Ji9; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738777719; x=1739382519; i=markus.elfring@web.de;
	bh=2wGvyYMnVgwfZDd+X3Vz5ct1HNuTyg4x337XNUZTx1A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KToc3Ji9eKlJRjf9lLa5NGBwmaib1ECzHS9D5u+mYXvnUfFelN4U6VMVzOrH2DWF
	 AUNIn6I4kQK56OVKS9dQY103EKmWgv0JmfFHBFOHAof5jFJJGj1IgU8dlqhkiVz2M
	 GvzC2rU5wV//Dni/Dezv3nK3V/7yrkVTeojQslUaVI5zIbB3f/jInpf5OFoCZJDsb
	 P8STSlmF9ZFa0tHRjSNSgtXBPRks5ExOenr4ImvZrZCkdYCb/SLGmLPFlfNF7CqsG
	 IGA8MolEYDMlFrBTSnVifqAdZgKCqHjSRzqeFNTFrYdVhHMibVQdqj8HGcwYBEtcq
	 Ft3y/z0bP2FHq1DL1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.30]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJWoe-1tzboc2sdE-00X3oZ; Wed, 05
 Feb 2025 18:48:39 +0100
Message-ID: <b6f97a22-4b24-4ca1-b9e9-38a4b0e69f04@web.de>
Date: Wed, 5 Feb 2025 18:48:35 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Feng Tang <feng.tang@linux.alibaba.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
Subject: Re: [PATCH 1/2] PCI/portdrv: Add necessary delay for disabling
 hotplug events
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mf1TZS7zMuR+t1RajiJ5ezWp2B9JsBYz+0mHhuDgsZxlohT+5GG
 uXNlnBicAwYLHxd7d2x3dLw8emHRubFR2inyRREgpVY/44B5qQvqzOhP8uqs3wsR+L8x35p
 McfgO3rZi7FLC0gq3u7EhkwocNUThAkHItBqbB10NzFcqQxcUpH4tNv0UcoiVPZ2qxK4hUD
 20nTQTR6ae12xnt8iK7Pw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:67Xz/2/uR7Y=;o1APCCmxO+pUUFUCCtaP8J9jK6C
 +o9/5SurHdnE93JNlRJqMiGWlK+fAvUqU3ybLF+FOPYUZ4TW/Y21r1ys/69a4DPLHMvSCpr2t
 /ej8UBepJjyiVGz8DDCMYIgaepJjHLljaHdh4x6Bxrhe2ZUvilc4XjlmsvO3pw68qV5ejUgeU
 lUDK4tWHfvlpFRqhlUJNzSxZOczKWIEpw1nZLhQpzgv7lUjaK0Pt5n4gwFyfeTeVtU05RuK7J
 ZaGW2P9xSamj9Riyxx8uZh/xLL8aeFhmK5PU6PWy2KubdGsZbNa8IEIScOVOuqjxnwp/L8dNX
 fmneLEb4pNQcxTl22fvhNM8U2AD9GGkp6uSt/CCu0Pxc3N0teSNxI7DQ+MkRZvB/yU1GpH9C9
 872zD5Iz+Jjv2gct3WiK4lVUOlNJrLnU/qapM0xZs/iI8kmYjeYpOqvzPlgQdudPc/5Ah3POd
 ZO+cF46eDq0p7FFNram6sk47/Cqh7DedIn2eqsnXeb94PsxNh5LIVaOUHXx6hZBKhsLA14Kcx
 W8MK1JEJhj4nWUD78kzqKDGKTmZS9bwdIQusx1kVLutAy5b8kzGhkxY451KTjAj5HHebi8GxW
 /nWhbqlzCGgtWLY1ae4PuU0VuEKjsdUzXauVzsNoaWwutd0ACvFl1GmaHSHnSAs/q900fm8Sa
 62/rwqTxKjM39pJx6/bYLav7aDQYSeKF4n2PlGVAFG1cAcxJY6yc0iRVqZEMwztEoOzWFdKMV
 q4eYk7NU6tfIIxrWF6el9OZDWu07A7MUJGP2X3PMYnp+xk2V2J2BJoHy4QmDoq5/OZHErUeEw
 Pm37CKx6LSVZqz25R/9Z3dfpGiV4cwTt1kVo5ZG8bT+4pV86Qw66P2IAnjmPLj0OIkKzOXFVk
 qVd9R4d5Q5pRxhZDV/54GUmqlKbshGZ8hma5cEJ72jCG4yJKsngsPizc5Po3HVaKHOiYJ1dQq
 fTjCSSD+KeYygM18/2OLOz6G+8xov+r3ZkI66ob10tkn7gyET5dzpMmSRB6AbZD7SX/j73Adt
 pcE+km3Db0NlUnYnOyZLL2hyY+QzXZAYcxiKttutC19xyJKdeLytn5CX+ymGuw0A/pyy8PTxl
 Y7kEHm9RF0k7++Q0CmHSWTFAhk2aHXFunL19KJEXG7N5vGXtG8XUQtAhLx4vvB7PHKJdh0rIQ
 z8saaldzHdx/YlbdsEuXJFGBph9SFmuVRzPjduJSO2L8MQJc7VDYqw7uIs+AGV+qSU3gG69Hy
 StALmGar+wA27MjGrEOP8VFJF5NyTwcgI+rE/v6W73FDN7ySTSj81W91Rv7N3jyB8prZdchSk
 /u0RAhMjzH+3KnqIFvW0KjlUvmucLCWO086sjUZCUJ+w0qDJcP2U5M/d6Da9pSbHEigmio823
 JZTQOWUnm9BbZUhZYPHUanYKZtrto0pZelhwkqylNIxeAuBRCQGBvq0/zAsM1OLPa2lo+Gy+e
 ymcGhWA==

=E2=80=A6
> Add the necessary wait to comply with PCIe spec. The waiting logic refer=
s
> existing pcie_poll_cmd().

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?

* Will cover letters be usually helpful for such patch series?

* You would probably like to avoid a typo in an email address.


Regards,
Markus

