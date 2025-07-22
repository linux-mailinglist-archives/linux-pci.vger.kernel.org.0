Return-Path: <linux-pci+bounces-32753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E341FB0E38D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 20:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9741889CC2
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 18:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A621281376;
	Tue, 22 Jul 2025 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jZD7vNB/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56027F747;
	Tue, 22 Jul 2025 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209273; cv=none; b=BufRHrC3PnDWwQj4MX7+mBygctRBgeYkzEuYN2zS0peFsDiuCjbsmynPHGcl7Q3D6t1CDfueZmSbKRj0aX45YUc0CsyFaxmEhQe33lKSSPEgaVamaNF3e2YE5J/ZJNnGUPZgK1Ok0O2Cwl52MFX4gGcUxXmDSq78/B3gQAANezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209273; c=relaxed/simple;
	bh=L3vufwGgI09ZsG8XHxO8HCoUgh5XQkAgKqaKlzDDclE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WNXYsCQpkJMsL5YuFdXop5rzb4aaykiYVengKjmLlEZF4axYQz8gB1l8Ad76CSHxoa/Rzu8tVW/X0gfCzUFuPAWm2DGweB5o3GoZB5itXbORMC9PgTxl8BYb9oCWl6dL3LVZMRGlDi9fYUciTDwKjhnr2ZVVQTfZMGgPn360t6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jZD7vNB/; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753209240; x=1753814040; i=markus.elfring@web.de;
	bh=/kcMsNZpnXXW+LfAHwa/O2YgzoTjb/rnsR6TqBrmKGA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jZD7vNB/MPYAKTMyieqeZ44bx+0srAqHiM2ROBn8o7R+rzZNa1WNua+uQH7F8Hbh
	 QJf3DMeUYVqAhcRb1HSe1inFuqGmlnHE0gNZ71/HqgUI4hsRx15BlDbt4RWnlPjhR
	 2GOiHnII8oW6K7CW+FmDCPJViAGk2MRAuDrsTUfZ9x9A2zFlz0Sru+635edIApKAu
	 0K3Xyzn+RlCYWB9dVgFI4lVh0a8uA94By1IFb+H4f8ni1EHdQFgdnwQ04EsI6wfw5
	 vrkdJ+83j/8ZQVwYdvmXwc8Rr1Mn4VXISm+tGf9Z78fo0dMjip5aysEr7i+jeYgqs
	 y2fsbvPSzyUqS6TJ6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Voj-1uiDkH1DW5-00rbsU; Tue, 22
 Jul 2025 20:34:00 +0200
Message-ID: <bf959b95-3e59-4863-bd92-84adee05f9e2@web.de>
Date: Tue, 22 Jul 2025 20:33:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johan Hovold <johan+linaro@kernel.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250721153609.8611-2-johan+linaro@kernel.org>
Subject: Re: [PATCH 1/3] PCI/pwrctrl: Fix device leak at registration
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250721153609.8611-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8vf+8TT0dTg9hS92+mlOh3EcTxVoq5GuFL+JfG4QOO1sUK5oxsT
 gRQSPhVAgSvqyA8I0ehb2ZQgQsX7E0OipLPa5Z3k87WPBUYvcl8joaW/VcEyy7fgplAFm34
 vjulMoiNRD/SlQ8MOozvHS1JH5geobYG6LaoMjH3jo1SE73t0lxHUPjB4ppY0x7th2IskT8
 RMYiHqCfvj3y9ccQygqqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OEomLu6boB0=;ZBR9UmxKLsBSRvhXK12b+Nl1iyb
 9NOj0DPL/indutuw49NURKRZgJ+D+zPXXLqs2oS4Um7hE7e6VFTRn9suwXAWzxpN6zl4SQYde
 HQqtDYNvsvE/KPSrCIoKrNkAr1fMcRurBvc81bXD+53MsL9S5hXoj5OCc2giCw1+xy7uREEKN
 zOvT45OrUJiy29wZgxaiu2tqvleSe4AAgonvHOaW0VxCi2MouNkq7yOqJJSnh1naTglqW8cll
 RmzJxjlTJOTaJ23iBAw4PBXhwRwIxojxt8zO58GRVuD50rGYL5L4Os2V6TNnRYRC60Aao9LWI
 B7l2ZAkIg5QshgLL4mPS9F1lzz8jbaHuj2GwE2yXIo5WOh6oPaxJty594ASfdnBwOa/FR7PtC
 veIp02wk0wpfmn9BIBiMi0HFrvRNAHcPrKlkiv14/TCWp6RCE4zgiq145JcydketgpJk2gwyx
 34tGkC1e/s9kxUcyH4bVRzE9f+4PvvAF8rt+5Ofk7Rh068wR7EdTRfWR4ESJl8ejyqPieLKCZ
 Rzyd3RvdHuimrjimt8Eyo/UeGCiFk1voK9987IMNTaqUyOa30HFH2L5/NlCBSxN/dHuinXFkr
 8mwMovzRdyWCvLmsVxchaENtclDxEwP/PiANrmxvYKAP8dkgOS4ewlKTTCUBgEN2AzaXPL6Fw
 zCDYK1hRWU9+c5j2OrYql0NlrkJXHCX5UBJSemlEU7zZeK4EBS4dGfI3zoyd0WKzFtjL6rDxw
 /ZtNFLEW4xexhBxXzgD2KcAUOzxagBp2cDuOnqpqWFrKexsYxEK/+pJwSg07/rnWxypOffBhX
 /be5fAnXy6UudBb+zzS3DKLTdJO/qvImsYC3x7W+LGyroo9m1AGhYR05CWo4tQ6rjCD+jDWDr
 aQUY744h1B0fU0JVxT0E73gbtyPEx62q7wEcCqcnZo/KSoLNs6D8aLB27nVvSNf7PNSRP3Y2u
 9oxhrzCUgqIifdwd5xlcX3hrrDKxm8bfhV3OgYcZnDtjTOgXAneZmh3rFQM1aFv6Zo1mhUzOe
 XtQQSvzvU8N6yXqJO9Cu7Oz7p0kKM2zqg9GKyPoXum4zmBGxJgE0SjI8X+GzT5cp0kyJ7yvz7
 Owmlm66NBe+C/ipaeFcDcrzApCN3cFPco/PYVRGYxFJIS6nWa0X9+Aw17RB6E3EtF3MDOwRml
 psqJFvOYArPPaI9pSW5/n7ReT9vEI5XumoSZD/JpiwOl++uXV/zMOBSAF2i207yuqKYXSywQo
 1h98EiLZrV6NwDJiRY8bAwS7hhdiMJE83u43n4FT8B1c1MQ+9Egsqjtx+SlYXGYR3VtqA1B6N
 DkLc/7nRHYg3wNR0xtocfbNJnRzpCi2Foomrwfp0/MFtnCILiPj+toeMXV+q6KjyFOCCTKxuQ
 yIQknUjPvpZIJzliQb85XKwPbblTG3LBniXAHVkIM5JKfGRtyazV8W9vFMQYxRJQyqlRq0LLz
 ozwvzg2b3654EFGwZ8n1m61gDCBmCHqnD0w6sD8ZXM+Z67qigtF7ARZ2XyZShXkGJIOEciYD6
 R/sFoHhUq6SvQQYzNZBJ9QAD0+GL/yQgWtcVIsNL61qWhyInu0hx14caKDIzRfKwQGuDPA+Cj
 mAlrtfGcxXH8RfLVl2ipfcL7AKjnaoR3SGdiNI7gAT3kJjn0DNZkrbkh+BMy75LXc2svHBKDD
 UfiU42ojCHMsa/OAF1TqlQbpX4kz7WUrUtqj31O+VTEgOpT3NoDhgni9qMRTtY0aZCMeiHpOC
 I6/Hg3PkUVMDowqp66uQsN67pAPB5F10o5IziDuC1QjH7D6IwbOQ6ig0I8rYDmJJX7o/bAb+s
 4IJy+x3hsQPB5wAILG/No45ogFXV0tFehBA8zMpmsmQA3Uog4id9B3Rs2AY/jpSOCZEAB/wCj
 8KvEj11n/YJ7ZZordNEWwdajO57nF9W4HWlAHVXU30eon26L4BfK10Q437piQ35NzqVIVEhQI
 8ehP5Cr4Y7LZXENhSawhXsA8kP+0TCRiruNN2tAIOnWMuXWzFSBGynkv/jVEFFMt2WE5V9wSG
 ewWTfErEQ6DiDr5qfbDq3vCizZGyrIOzpTrXOmm0473ZeWY47dyy1Jgu3CqsFxybbStUGoY0L
 Eo//7ddk3rSrKFeoXdgDWDs/MFCck7G3/SAH6QUXpnWO+FlubE/yMipiEhG7ABAX2uxYLHKqY
 Kw+DMDI+GUF50i7uU6o16hQa9QD6Y82ktcUXMIo5dWODgbXxKPICTIUv36xMdH9lr7I6UOymS
 Yw1ZOY3vFn1PQ1GdH6eAY9ukcMzreJeIQZv2gbiI06bEJEodZSN6Q/IbxrZZAswpcMb+lbkX8
 8vV1jxgGVqsZ0IlmSZsfNRFJWDeDgAeoAsSIQO9rV/JnwxSzao14yTrYTL1drRy91en5nLLzg
 zEoSari1dLYUneiWn3HJFId/9W/ENSR37M7iMdgwxeQS12aUdnw3u1cH4l5230N3vBfuo1hd9
 N0JY0vFzn2JItZ4+fIqQQ+ReegfM2vC8HUn4LEynj0GHubdRgmiuTm/IO8Ts+lur7uvWcQMQk
 VnWYBJ26NJsvlDyiOlLKPVOO3b+WUdu5sOjFiOOVAXO+yUbEMTCSmGzHuGez8stpPltF4XiFV
 riCYtkJLmWYCEd+BXe4ZASfSUt7sq3iKlBTNgW0A57LHjOcTsvWZux1Jmxlvx1uQUUqC7LszZ
 nhp01u0NWhu9XqyLEIg3fzQdgom+ka8/br2mJl5R7WGe5Fg/CBAGvDUKghIMvcME48YEI2HwQ
 qMkhwI9sX4eWrX4q0T0W6hc1kS/RytJpLbXMLx6iDf4LpwCwHaGawdO0jh2qHFRZts5KYDNDB
 +EqjtJ7DyNhaz+x+/DWumwX07aICMIcB7LpqCoTmNOZDe20xbBAWWdFTmPaGPGE8zEWrt9uuo
 cTd9X3SlL03kgDwc2uzT80zHCZw8lJSBhJ5o/q3dc0LfhOdzn93/1wvFIGVrhkcWxEH/OhfNj
 gLf2EuLYuinhme4F5wP82DfvX7t1F+MFZwf77Ef2GQOgGfjGzIcRUGIHc0zXty/ImUM0uXt6W
 l3+cA2ThXsvNENf4V3gVB5L/o/+zASUblZy0ulMy+besaZSEZy1gNpdVI3YCI1Za2ZMn8JLF6
 rVY2JC4YnidwAIsuW4YNpLB7j3YuECuD3DZBAZXDVUc6+e62f6xp37/+PBjVroTthyDoBXhRZ
 hZt/6udd9l3/sEaeXCYUzyXK3C1ybLxZhuYZ5l7WlwyVRpFc5QAEjignYk1EWJWPlcuy69eLa
 uhCDV11Wc2bOzaQHxvpMJ5axwWFwS1HEpEkjpqEDjGn3ic3QEYW0iVeE0bx0v6yEOJZuuQq7i
 ovCEot1nvEi6aKZBv86pD+o6YBRvA==

=E2=80=A6
> +++ b/drivers/pci/bus.c
> @@ -362,11 +362,15 @@ void pci_bus_add_device(struct pci_dev *dev)
=E2=80=A6
> +		if (of_pci_supply_present(dn)) {
> +			if (!device_link_add(&dev->dev, &pdev->dev,
> +					     DL_FLAG_AUTOREMOVE_CONSUMER)) {
> +				pci_err(dev, "failed to add device link to power control device %s\=
n",
> +					pdev->name);
> +			}
> +		}
=E2=80=A6

How do you think about to reconsider the usage of any curly brackets
once more?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.16-rc7#n197

Regards,
Markus

