Return-Path: <linux-pci+bounces-8994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCB690F61E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 20:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5802A2849AE
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 18:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24634158202;
	Wed, 19 Jun 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uNPpIIus"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BD922611;
	Wed, 19 Jun 2024 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822029; cv=none; b=bcaXD3ZLm7as8+EncpZODTtaxS/zN8sRUtr6iMFvugDwE1nZdMCxuKo40FiCQ/HAz6qrfAp7KJt/DfB7la2VUczW44VmoVwjF0d7BVUbdLsoFuZzIs3TfvkoqUCZk0whP+50O6YI1n9PDPwnSJKL61ZvUCncQx4/bqQwaslh07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822029; c=relaxed/simple;
	bh=klT/MEDK+iqHzowZ42dKMm6Fo/4txAezjBZtZFya60Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=TgZHBW+6Mrqlri2T/jT/BV4OFH/L4cMqp1qZR1CByHIRKcL24eHpeRendnV6gUKMNhMIPH4PGYamHP9rOUbV1keoTaCL39qbPqp3KvWPjVUdoaSngZTE3vXG9W68zf4hysZkm9kNByDHruZmwI7D39q1MKdRE3z+r6OazZBgRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uNPpIIus; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718822008; x=1719426808; i=markus.elfring@web.de;
	bh=i800WlAhXWu+vTAREXBQfo6LCf690lbMECLxh1W8134=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uNPpIIusasB8TowdkiNYGo2HY4U6NNYS58/j5hsruv4llX+4VU05YLf/smDZorof
	 I8D2bJ8DuUtyRaPdYdki3G+CfB8RemROZv1hvPf9k+6H3KO+sjlPjK8NrgrE6VkJ+
	 vhP6qeXgrrxiVO635ecFOfK3pOFpgUa+69Bfej5ngYKVVVlzohXA9ZT3Ayg/3JZ+8
	 xJ+Bzr+j4wCaletoH6ltgx5eTj9WAZvI9fBCSplaKOXjv1Tu/V+FrP0dZjKMWjk2t
	 KWdhzRhw9XmxZ7GTpJDLi83BZVG6lAkST7GHuDuZzv0ARhPpBiTQL2KmBKNCoVdvl
	 /xVyrjyB7LVBYXu3yw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6pf-1sZuEy3bDz-015Fge; Wed, 19
 Jun 2024 20:33:27 +0200
Message-ID: <2b8d9f45-97da-4baf-b72b-d91fa63420b3@web.de>
Date: Wed, 19 Jun 2024 20:33:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mario Limonciello <mario.limonciello@amd.com>, linux-pci@vger.kernel.org,
 linux-usb@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Drake <drake@endlessos.org>,
 Gary Li <Gary.Li@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20240613054204.5850-2-mario.limonciello@amd.com>
Subject: Re: [PATCH 1/4] PCI: Check PCI_PM_CTRL in pci_dev_wait()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240613054204.5850-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FetYqQi+NNxqQ8RibOATyt0kcZlVCg28SiogwKqtvANBzWfayHV
 VeU+do13p3VYaYIiU9mp2b+WAvOtbYXN8Wf/7D3ZO7GS0DgQp/JuItzq102SA/LCn12Kkpa
 92e3rXb/Kxamh0E72HA/dzaUHRQ1Lz4JgLPoQJR4/X7c8+2UdER2dUBEQQ+RLNhSX45ZBUf
 NgvCHTc1LzGuwVq+8Ye9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aQBU6rM17lg=;VG4N5PFT6i80BTuuJ9nHPrhuuMg
 HfzxsMNzAk4OpIwWCJyZfJmcQyysyDnaPpC2Aq8NUDjKf1nqt5SxsvVuo1HB+OVVbn/bAa1Wb
 jTbcJ49Mo5CiZxhoo9aqR67SWBpvmb3+1z4hFfHavxo28ep4yvQ2TINQ18RBXdtWJ/ubhHXbZ
 GGnE/Jj0ZJesoV3ZdQOYk0G2b+VcIvTwBgWPVeLUc7xImDgRNW1/5HB1gAT5m7uo1cre8ZnmJ
 hhled89NyPx+RsCA22exRlpApCyK/397Rm/hEMGnQou2Qj/XoXW4wx9dsNTo/3l2Cm2fYY9Kw
 h0+cP8zjqnvGC1kG2Q4AxVUuTo83hUVugbOLKpU/KNfsq+BHG4KPUQb3qadHiiOG6eQrUsgg3
 Upf+DoDY8ii5aML+G1ATm6MP6yai4VnkGn1ZFJWu5kwE1VCDAvrXfQ/au/k+1qDgVov+KGeZ/
 T8Lc6C207GvAy5zZCORdXk4g0Ip8cdZdmIfIKcscmqv0sZ8hUnfpUbXbMM9TIBoG8K2wEgdT3
 OaII7jh7uO02fmCdyxLVKlILb3iIBqFE0PjFqEW5ZWMuqDVlOIVrcLiszZnkx3v3vIZOLNPf7
 /aKeoO9YeOjgZSi1/muXjGCFRlFUxtCHNH0Vlz7IccQkO1yuVUZ6DdC3ObH1qRGC8/SlRn1Az
 8V3v3HDrRy2gt1tQ0I9fBUgap+qWPJOwMt34iAKWdC1W+G1nY+FMJBw6drOGFp9Cgs9TiZ2qO
 kHq5kBqwJlwsunDAbOZWALcowEWXEREZoN43VLjhYBgpsZVZt9OSZ0Y24oXWD1nTJCuMqnQ7z
 c0I4IQgDlXhee8+J9gLUG2mJm69AfKF5PWJ9BhqzxzJfvnS7h5DCXtQzv7LtKCx9/Q

> A device that has gone through a reset may return a value in PCI_COMMAND
> but that doesn't mean it's finished transitioning to D0.  On devices tha=
t
> support power management explicitly check PCI_PM_CTRL to ensure the
> transition happened.  Devicees that don't support power management will

                        Devices?


> continue to use PCI_COMMAND.

Would the tag =E2=80=9CFixes=E2=80=9D be relevant for such a change descri=
ption?

Regards,
Markus

