Return-Path: <linux-pci+bounces-22183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEF3A41977
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 10:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F89E188C2CD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 09:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596FA1B041E;
	Mon, 24 Feb 2025 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pRolsdAZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8919068E;
	Mon, 24 Feb 2025 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740390470; cv=none; b=GC7AM89iNNCSk23zUo+I31v9JikP1v3wxm7zm656uVYp3DyvZlC39dUuf1h7jzyJkwgQnIGz6+7pO617MKZLYbGDzApa9g0xG0akkST5Atrr6Zk7Qxexb5JFZ4gf4gD4oBEUrEp1PATjHY8rWyWqqB9zarAXXXqm26RMPDJWPIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740390470; c=relaxed/simple;
	bh=9BaNaagw/ZNHIHZIGWJapW+0C1OmfI1aZs/907nTjNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ab8caUYDeJ63Xer9RWTFppKnp9VRgo4taLgF0wdIcNXkFaGO6djd3WZSt9oOxDqreEo1QF0WkBPYWo7pRp/0LjsECXLhBP0Zu+gN3rcrxjOs3tYEM0ti84Kg3OFSTpQK8ne9Nm/W4+OIN9+2/OkBF/J8pxhz61aTMd823PZNFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pRolsdAZ; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740390425; x=1740995225; i=markus.elfring@web.de;
	bh=hRH62ND8UNosmEYDdA1QCyNtBT0pt/8MXaWtWO0/8yo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pRolsdAZtwJZeVqEjidyxnkbVNPR0yCWUAof4/2eRrmAmHCgY9a3Kb/FAqH/0GhV
	 29JbxmharSUhUVrGajDbebQvoLUYL08oED4DvqAF7UsJ2kfRwatBc6Le04/pyaIY6
	 Ndk1fplkZCwARWb2rk49RY8S4rTe5wuA2hmJUxLk6z5/E6EMrcS39VIWDqIeD+7O9
	 QRlv6dfpcSm5E6vkCyJg3DZoRgGsx67zIQ448HcwWVAknVmK+drj9eBRc+nlQHFSy
	 ROFlXOu8Gsm/gQfktflMLESJiQFs1eVWHfj9mas6vSqT0FbTxoyaE5lv7hCDBQ2cd
	 fUtCo9lexU2FSNTrew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.37]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjgSv-1t3JPW2Sol-00aAzV; Mon, 24
 Feb 2025 10:47:05 +0100
Message-ID: <1f41fd8f-c811-4995-8e94-bf824a9c7f06@web.de>
Date: Mon, 24 Feb 2025 10:47:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] PCI/portdrv: Loose the condition check for
 disabling hotplug interrupts
To: Feng Tang <feng.tang@linux.alibaba.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Guanghui Feng <guanghuifeng@linux.alibaba.com>,
 Liguang Zhang <zhangliguang@linux.alibaba.com>,
 Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
 <20250224034500.23024-4-feng.tang@linux.alibaba.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250224034500.23024-4-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rAmKrLzRoKv0QW82kY5YP48J2FZ9xjMoF4dS8F8J6OCIHCFi9nQ
 iA/8IYAbw6665tiQzwvP7xvt+mlZXHnp7bq2iB5DXCApbAufzn8u1CIh2b4n8T9/p6wIJZ1
 1qHWGt426tiYy3hE/8cMO1WpGoV0fDhW8LmM4/ZQTmP0QYEJ4Ad3vKZXPyJY5p4/qTwgKWy
 I8aF0uaGIfBWE3J7f1h2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RB8wIQCsvK4=;uAWktxSLvqGqVrzfdO0UNZ5eShN
 bJm2d9lneXflGtEeiBILtTnj6KteeA+5bLPC9x0ybfxHrA1fBqU1RUVNw/dEH//EhYXTYePVM
 fZ+jdt2e8LqOSZhdXXBJOSct78oxdq7OOqn33XLGTVhITAu/CpCJ4nICcMM5IbP1odguRei8z
 rBmuKjUkDOcB8BNLD3GWHuwDE29RYEo0ULac83G5+ZRPCNNc693Pw519S5oqcDmp0XFoZfSas
 JAzk02zeEtksJCwcIM+3i1oGxSIeTEnkLu8egdDTqfdn5XhSEyQ+iZvC0ZMD2JLRlu7Qcvc5T
 CiKTBNNvfY/Zivfr7sqOjLfDhZWpBIL/Xa4eaDX2b/T5ImWfhcLbZVydqC52jZORMD3R72c1U
 Vuh0t1oGv8sU3A+DOXZ35aLvgOKgnVUlooXoUizHqieY7wvqbURoS0mkbvZyFaOqH02qgaq69
 9X8AHzirSKcuCWIrirOH1bwURLj52cTSLw8loMALjsacjbGyT9XttZSGPkST1XlVwqLdIIxbr
 vZRYP7pla0kVsin92MhnHu08bix19oUVDs7ms5bBUoBIaSNiCtP4mP56T5DPS8zVdP7+mDpMK
 /Pv/8bTt/dL+729wjJtJvMra2P3ltQsgsmFAKUQU9FwVKBpe3rU1qbtnje6ggGvlNduJVTgnr
 WACKXf/QP2kvg27lzjlYoRqNHKxWmbqLLttyu2FIYjHwIbQrREqTIS/6y4CEZCsUHH6r37Y8k
 7DGlyJqpTwxf3b6drEFnztSFq9VOcfGGVLm/fk8ApLXdNJdyDsmvJ2F5GA9Mr/f34XpXm5SUx
 qEeKux1GLhfwhsrLh2uujWQxCc+vuZqsveCFq/4hoWZrYJBqvDqeVS9KVbo2rnclO0+UG28/O
 xlBTd7v5SRJgHg4PcyLjN91UV5Ruc3Un44sbqQe8GzR/uJtTeEGZLVWWEnRaqpROuuHcwf+hm
 NNiPYem2fGpN+qV0o8O4QgZD6xAWEJfQPcRTmagoahnGbCPdDFcMAARP7a8A7nlMatvVIGEDv
 vJhRYOtOBBVhCgrj3rbo9sOgAUQ+6psVMxEsaQxGfb/LCU59YTSWGkG1/XUEopLL2ujlHVHDp
 AuGMPyRHFHHCtyvP2dss1aG+UqXq9KSMl6wkgtB/J4Z9jIgtL8Mw6/rvLS2LSoVp3sMDB/AXE
 np+xNOeXq60V3TJ5cU/TXgkZtapc3XrM41Gl84azcvZTBLzrrIvjTZ3TCIsbUWnVfQJQjyKT7
 IGMXNhotm5VL821i7Z0mHh2nQrZHMa+mnoTI1Q88n1ne2h0IBFrCKK6WgEWl+th8cErpdvS5C
 q4ybFivUCYfKoiUTFTowt7lcMf31DipGmv8xEWscuhNbKgIuEH6+1ly8TQc9wDgeN46Egc2Rb
 KdQ4N2/b81M5pWqDIGrGQa4NV2VotDvfMZ2ZUtSZjo67wEG3gbchXH/9GlGY8LyXM//2DRZr3
 pncQXqbj9+CLfZFDt7qEE6lnHuy4=

=E2=80=A6
> remove the depency over them.

             dependency?

Regards,
Markus

