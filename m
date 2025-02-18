Return-Path: <linux-pci+bounces-21698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9736DA39653
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 10:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AD91884DB7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B50220CCE2;
	Tue, 18 Feb 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RG/hHpJy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72EB1B0F14;
	Tue, 18 Feb 2025 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869284; cv=none; b=bVmduIGr1ZXGvlAf8w8EZ44CJAipMetfw1m3KtGvFKVJholT4+1EnsegQrITz9ZSVGJcypOjgB82DIsVS85OhwF7eQg4JOAxfcqLLRz3hFAHWITTy8vmdst5Zyi+ZPpD7su4V7+iJZWoKxL6W9iLh4AT5MX4RyhtCUQJgac0wEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869284; c=relaxed/simple;
	bh=mYRhqbQzxki7e9cqUCTEnLpx0IJ1POrXuTHg2ZLhxwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CB1lT28mpd4ddrhdqKmS6h4idmJ9qkLEoTrT1Onw8vXkmLyWDFptYgG+mAcVPmL7jrsA9evgUXODwVFseccSlbpeYtamAAcfynNQNznr9rJllAzBdtAlzaTOsXUJJlE/WWhfNtptJ8H3Ak+asJNzZBQWDoBuO1kemD0dovAreb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RG/hHpJy; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739869245; x=1740474045; i=markus.elfring@web.de;
	bh=XIeNWUy0i7uKVdam6OUW5o/JfhKLq3GrDaCwK/XHy98=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RG/hHpJySDz831Uj5zWPWGlIsuIqBwmozAov4IWV/Sjh7kpJfEX6LaCr/0PM5oQb
	 eRMBqJrpysVeem095LBuMrngsVqIMzHfo6l4aTcUE1Lk9xDHu3NKJsTxUrqTvxxpL
	 ce0UNOVeAtwN0gROJVH5hn1EztYlVLYXp4GiPxeZIUw/YAQVjR4VzibGZMbohNr+b
	 23nvJ5xt0Y+cHCb2KNbJqDDg5VTST0/BzGz+4lqfQICh+N4Fpvl4aBU2tr3DTUG64
	 CbAkAC9rpVmxtwODMF+QJ6HDXZjI6/To+0stZlrB+M4snHS8LfQRrDMK0syUnZjA2
	 iquGTVZx5jyv0B7sgQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.27]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgzaR-1t8EYT4BVF-00nyEH; Tue, 18
 Feb 2025 10:00:45 +0100
Message-ID: <a7ebd733-3fdd-4163-8fd4-9f70ee40c6be@web.de>
Date: Tue, 18 Feb 2025 10:00:33 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI/portdrv: Add necessary wait for disabling
 hotplug events
To: Feng Tang <feng.tang@linux.alibaba.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Guanghui Feng <guanghuifeng@linux.alibaba.com>,
 Liguang Zhang <zhangliguang@linux.alibaba.com>,
 Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250218034859.40397-1-feng.tang@linux.alibaba.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250218034859.40397-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:URoPd7SSVS0FDea57bTR/aB8zElF/OAqEYqB9SpmWYwapHv3qQr
 0xmHo9SAAF6sOPjf2IYGWXkocBrF/PabCPPEr1IqgNc743xwTmYXkXYXPGfBOkYjK5HGNkI
 ITBPALIEgu8LTgw3srzmvrqola32cf4ed7IRV4HUJZz2g29BeFoRWO1mTvY/BkR9J/IhTCx
 wdC1VyghJnKFkFf0MwX7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C3/VnsiLiBE=;hVmDWSBCuF4JBVmDfHp2CfgN5PN
 LLKSqKME0DFbsuAEAemApAx37H/Q20y5HR6Nl/hPP9iSbWmdAYIohdAEOO38F5Epf0Beax6sM
 s5h8LPdT0U+4I7mJ+CWqQGvaxIh/kga4nXmxmIDcGwWRjWmG6jYNfJvnXFFjG1iVBW3JCZs4R
 cSl8+vbW7MdOI9a5b+mGC+Ca4HxF2Adtrdk7XJB8Y1B3d9AmN+beyWUET6KXhA7rQHhTOCjbX
 lPFVy/0JyjUOC1BLfNnyi8RzU9AijBk1MJ0J/6MMhW7yQksEMjn1dg8MVJnxfMS+ORd6/2Q6U
 47/Rb929jjsc7KEhM9ddRmsKgtWuIaqmD+SWyH6CGJSO6Gi+0rAHgdo6vBwBAEVzS7mxSNXFZ
 oE+vEuVTCIeTTlARrf/tqW9UPTL5KBUc2b9jglLVH9jjdspry/G3EUM9yV7wGP2EVpCwkCSwV
 BMWcqm7hcjx5GAN8zBMxtAhz6q3ak5igukPpat3Yw2KvvDgC2dbKTat0frBdRaH0CpRQoDyVz
 MPOzlrodOOj0xbyoXUNVNcovGck19o0K924xu40S/JmdSS01ItmNt5juL9W5FGKWuSYXmvi7V
 xzNGYxXxulbIvKBXicIWa5NOmwAPrcqdjzZWvh5Hd6rrbeF4K9Z9cRQw1yEQyrAAWmkv4er6v
 I2ayvYh5Kxoas5pGbWjIL/2jwjt01uxtUpNLZBQRcARIDFhQuHfhXIaRKiLZ8nQwO38hnlTkE
 aTOB1Y25J3NCcgGgF7P7eKRz6ATfPO18vZFj8QRJwtNM1kRTpxKyA8nmzWy/11YQ8FUQAHlVk
 Cx2eIlkiLTq23lMw4nzgxVYuYgdvJttgFQVp6/J0cx7CP+lrUsxPwLqMPt8kcfy7KJqC7/297
 uiCri3hJ4xobkQH/eQ7kiiaXuMp4ICD/C+blBvQSzYshBhmTIl93Ek5LXF/nQicjJf8vAUzoP
 HXWJDdrhsLlrrocNVJTjUdMdUIEOSQ1s2/gWceINTOS37gePseq3Ea2tyzTW23CWQglOmHI27
 dDNHM0G2gAAFqs81sUhHJvmm9oQu03IZoc+/DasVgCs4Hs6hnIbutNXfOKxba7N146eYzqops
 n8Z7Dr0dMBP5w4QVC8K/V6wNHuYMpneIWR+jRrsEK7DsW1LHpjL31dMFcFuaRweq0vpoLChxV
 CYdF0zgR8F29SnTFVdYdI+qkFvqAhwf/yAlIOIhEJyWEpldCY6n1z3O4umi2wV+tJri0XjhVT
 k8YucL2NmPYsoWV1+b/U3Ec/E0a9ugiR24Gd6n6AW8f+rx0VjoEpqhQDF7fIaIgqLmqWwo+DE
 E51EvPbLQ/d96CF8v8gRoDhpi6x5Wp76w8DyDd+1RLrR70BAyk+6FQ3XgpSoagS5ITLF6JUs+
 SQJvviJb1YhIZ4AjrG4530S+noHqcKx0vWqmOfpFsbrgsZHB79s6js63h0tFnruVUV3iG6l73
 w4+RNebexGnlgtu8iqHRCfo7P+mM=

> There was problem reported by firmware developers that they received
> 2 pcie link control commands in very short intervals on an ARM server,
> which doesn't comply with pcie spec, and broke their state machine and
> work flow. According to PCIe 6.1 spec, section 6.7.3.2, software needs

Would you like to use key words in consistent ways also in such a change d=
escription?


> to wait at least 1 second for the command-complete event, before
> resending the cmd or =E2=80=A6

                command?

=E2=80=A6
> ---
> Changlog:
>
>   since v1:
=E2=80=A6

Are cover letters generally desirable for patch series?

Regards,
Markus

