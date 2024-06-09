Return-Path: <linux-pci+bounces-8504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C4190166F
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2024 17:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430B0280D52
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2024 15:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08CD2D05D;
	Sun,  9 Jun 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="V098lnKN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DBC1CD39;
	Sun,  9 Jun 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717945625; cv=none; b=NnAenW/WMPENa0PmO561pQqlBnvlDHPohxLgrhLyse0nSVot4qPJRTn4LEJO+NVOekJLx1LZGbzwDWk+E7NBLExgpdaLm/vs5kZlMNAa/G7wt5Ft2Hm8v59sRfZjhV16VVbUlIURFwBGGv86vlR8PFq7gsqV27qz97ScjnlfNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717945625; c=relaxed/simple;
	bh=fLbJEsIxiyickhrx/svmDe6ThGq6ThhEZBgDU4p8vao=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nyrRvDrBKvNrXCJrISsz5196tdF0X3ZIpmM6qMW35ajhH81pRvepcGpDe04x3dsqHOd1KNzIY2H6Dq8qY8XgDOO8qMvG+0ulcJEkoLPGl17jYvUDJ2CMN9pVDkyPTA/xsYIzJnURnkctjBqnLMJnFFvBb1Wi+ZlnkOAoilw1qdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=V098lnKN; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717945611; x=1718550411; i=markus.elfring@web.de;
	bh=fLbJEsIxiyickhrx/svmDe6ThGq6ThhEZBgDU4p8vao=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V098lnKN65H6s1iBfQxr5C1GuvkwJea44udvY5O3EHmEQrPAxAx5x7K53SPkdxQG
	 w6FNq5Nx8OVW8HQSf9Tx9jeBWJqgdxea40XLYVhJ6Y4MILE7+5bAysWK+QZVH3kjg
	 xzocMUYYwQKlbAkV2WEeWC8AkMMF1DP744tq7ywgEB8UgPRMSbqpPMJaOj1iHV2gR
	 Cto7h/ZFKwatkECMA2NllmjOUbKGA9XHpCWkLnquFCLdfwZ/q+Z4tlTQxE0K6cjDP
	 OG6QsotK8JpD8ePltQSVlbvvHOeH0ypuZJJeXugc+zwusRMKFMFn4SaruupOo0IHr
	 zmuvQNK5wpIjmfuw3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvbiu-1sXAIH1mje-017wbs; Sun, 09
 Jun 2024 17:06:51 +0200
Message-ID: <af71d076-5bf4-41e9-aaa4-ceb2d32933dd@web.de>
Date: Sun, 9 Jun 2024 17:06:44 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Rama Krishna <quic_ramkri@quicinc.com>,
 Subramanian Ananthanarayanan <quic_skananth@quicinc.com>,
 Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>,
 quic_nitegupt@quicinc.com, quic_parass@quicinc.com
References: <20240609-runtime_pm-v3-1-3d0460b49d60@quicinc.com>
Subject: Re: [PATCH v3] PCI: Enable runtime pm of the host bridge
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240609-runtime_pm-v3-1-3d0460b49d60@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QdMqJ+7+OgqaIUzm36yyD//L6dsvHBvph1cTO6CyDk5lFYil1QP
 /iYbhVwQVeI+62QKcayD47NgpQUaFWcUxM4nMmHl2D3i6SnmeSYamGWUnn0g4ZLFqI8qyVZ
 UUAseNqYoYDe67YY7Zgi8uD/MK8F+bRvBhaUYIdFgL5TCcHZdx9wArbqZrxT4yM3ES834At
 hD3yFC6SRfZIJTjQhXXuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hcNknEKYdVI=;CvDGzeWTWd9WWGmL0c7EgTX3b4y
 ZXqP/Ts51uPQyAJqzWyJwfkpbFIqOBegUXUVChQoorD+pp5LhvmtAx2bYu3qc9I3vuAruYNt3
 6ljYODzuyBKWqa5+uG2BH2rGxna9Gv0AtOqIZZiGHK6sIaWdmF0WwgtnRll0jEpQjGwwag1rB
 47w5j5lkH+DPYNiXXm7MmKSmZtGaMaQImm4+kBNUMjtpSJP187bonzbGo0mV8QTOlPBMdlUyD
 tmmymFa+l+ac5wHt1s1O23bVrDMdzcN+ohI2GiTM1S7kilVrm1Ujgnubndt6K1Y/FA1z6MlKi
 8j15ufga8TlJHP6hZ8DA1T2HOo9srK5nHG939sc06+7YkgC7uiPtjEvE5qvB/lzvJjjDNfDE8
 rQZKdnGXp4UwlwFTvUodPuEHHKctdFMrjlnwmzvMj5b8XnvU+SvztKeDN5+faf/fF7yOgqgj+
 YmrMutLjRpwMXnzn1/bkbx41SVJMXovfwAYnuzaMUOTqTvpgsK2uFMILwQoKCyVcLaZby1Wfx
 +IeBGzS+ZxItGyWG/tanQ0Z2+3Lq8FlT+sZweLAhAQBwzh7PUnnPpQo7ssifVG2lFDJVU9MUX
 N06UanT9RdQIbX/hU6He7cMMR0rqoyLwkRiRYWOjqnF283f/WnaMPYNsAcueVQyRBl90Cp+8X
 4DGnoIvvbvQtYedtt9x+HgvD7Hjx+AtAqyQaqSqDH/huXQRw29nDt7tsqwPRL+C2pl6rXApiX
 vXbxRMZr8WjuGInx366gLY3b4OiZyl8KIaKMzqxX4ONjoh3fRYHraH1ZwDDsoz+o0HjaycZpW
 3SW/yvlF8zEKkBsoHSJ3bgvjc9FwckmOdi0phwPqnCTv4=

=E2=80=A6
> So enable runtime PM for the host bridge, so that controller driver
> goes to suspend only when all child devices goes to runtime suspend.

Can the tag =E2=80=9CFixes=E2=80=9D become relevant for this change?

Regards,
Markus

