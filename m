Return-Path: <linux-pci+bounces-18870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605479F8EDC
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 10:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45E27A1CCE
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E21A83FE;
	Fri, 20 Dec 2024 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="npDL4ylS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962B45588F;
	Fri, 20 Dec 2024 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734686581; cv=none; b=ksbm7ov98cF6vQJkOQWsu+5cu+3T48BVnMncqcmRhRvZWqHp+nYpSiD4gR15lyeKZnzQVgNzxOKOFmXvSKOdeXMQ6Vo/n8XrJOztYf/fVNUBn7ovR5GukVOrcsZyCaRwPrz/DubtpcYW/K3ThBxoVoCPeLquB1rH9Xy4MmjJvuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734686581; c=relaxed/simple;
	bh=RgukpNpRyEuWyU7PNShelJwFW9poEmjxhFBmJ9tU9jE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DicdDXALrIfKEN3wz2GEPEd/Fq08UfLSZC3X+lJb4tegkbs8tCuCdmI3AvxiX2HGSpPTsTrMb1YHwh5tV9a9v8liy/21bXbL1dU9eNtMscWwt4zn0QIJCgXGIGTbUpRf1dfTQNE6B/FbO2cFxmLvWaWJAC6l46Nk7ttsqzQEW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=npDL4ylS; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734686553; x=1735291353; i=markus.elfring@web.de;
	bh=RgukpNpRyEuWyU7PNShelJwFW9poEmjxhFBmJ9tU9jE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=npDL4ylSmduSZk5dVPuhxXD7Jfa7BPJHR2vLy+2N/KuEbgc65z/gVjNFYvOqvsif
	 UByH3DVroDWMiGMaoqM2GN1l9oQv2uuASx/8U2eMCQu+j6QQhJRXhH9qOL8YtsyAC
	 9n2b1pX/aShrB/OFhoJnKjCVYu6CK3HMyCgx95R+hAuBZszXp3LAqupXUwKuyB+jT
	 TpmI2SSfww0JiSP7tKWlJFPmFW6U4LMnqayeOeusfroMq1zu517t0VhkAFIro9Ps2
	 Kw0HC88TzAniASe+2ZuNvlFWJfnU75JU0ovJVTMGfGXyYqOcUC2lrnoev9f6h1YyN
	 0yWeFetqlyot7fkC4g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.21]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2jWK-1tYdvB1DiO-011JKu; Fri, 20
 Dec 2024 10:22:33 +0100
Message-ID: <2284f3f6-5ff1-4b1a-8eed-d0e9c63d43e2@web.de>
Date: Fri, 20 Dec 2024 10:22:30 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hans Zhang <18255117159@163.com>, linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, rockswang7@gmail.com
References: <20241220075253.16791-1-18255117159@163.com>
Subject: Re: [v2] misc: pci_endpoint_test: Fix return resource_size_t from
 pci_resource_len
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241220075253.16791-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cY5aqOMyXj68ySWA7rDmAGJSF79cfNgpA5cmhjkpthbnUW7NC4q
 G0piM2+XEbRvZtd/jn2Nqc9i5k6qeadioG2dMWszfU5tNkZz1Eq4fKn1Ctr9H2RiU32GS9d
 es0L9pZpAjADn+aZyHUqTFrjM+sFKSshQ9RHW5udf834Cq4n8nhOqisOrTdz7nStmgqLzEA
 oad/m/PjKgiudSlKYf8+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eIcslCP5Xis=;HHeS5Z11n6TEA4+RH+fYRt0WRkz
 ZSpHRt3Xnvi8hoT90SlzR3LGJDFyMu74JoDTaRsnTeE+WNmV6UHrTJHHYoQXmtK+hfjVkJqlR
 NDJWCEHEyFxYbxqUcC6nGw7GKcs0570OTHG3WqfKE6KtvWwQR4yorm8AX240a8u14xi2CJcn8
 jlLqMoAmlfg30jsRzP/3b2fOBCKaxTkkjhhcgR/Wdl8pfrioD2xh+yiuLn5WkpnvQx3+3zU4m
 Px8INB1EwS3dzhdXLjWWwUEqqzKEgs/3BWL1QiBvv2bzyg7aRczigtiX6HWPNQ4dbx6kgrf95
 hC3WDp8bJUkYxet6xzSGqD0yPoRnrZHE+UZh6htje8XsBgO+Z0yXyJ6qKkuF88dchxhlkOcF0
 T/PX6QbkHp+tmuSsdtjuZZQk0RE8uXtEVuL7EwzY2RfxMYYB+oA5MjebzqI86ZiDtYAvVmORB
 8+ONGF35UBkqPEqvuznOGT2/7hEy7eP1P62DZamoRxBtLMOPPbWkxTW4YzGMi1Np2PpBxXmdp
 WgYaPjxD9GES/1ZJv43w3QWgHMfq6nKZkl48ZQUOJkZEEC+xwH+aula6Hlspg6eHX+1K3c/pe
 6ca2tUqeylX4obrb8fl15xh4gjJwDLYEFM2GMIYFBHdgUdPE86lRzeOgmNXwGlQldksefr2ED
 6JVXVnPWNDcMeqtVUAn5cJd47IuoZPMCTT3OMP59p0qncjRbhsSmwOY5LoMdrzF3v8sejELQW
 4oI5YeLCbx5h+S6I65tGvGMbjP4bO2DgwAJo0QTgR3Q290azJI8dHvEgY0nu3gUTOqt9Nyl3Q
 3UPDI97sdPWdfGztIbc68iA5webd/6SmMr/OxKiGcehhB+NbxiMrHIesnO38Zu7Q58eaMSHDZ
 d18zlBSeaIT1SERUKun0NY93R7QwXkfDfDsZy3Bvrfg76pf3jjLCpF5VjyByrTNL5VkFQ645E
 LNX3wU8oMBnbyMO1qZODR0+SBuRh0wBad4wX4YiZ4oPHoSg2qA+s+2v1Iw88/Hwu+Of3WuVcE
 rIpDLP63VZ5o/Sj1H3+usplsjlfbi71wGWIR6F3xVNvMrTnJpBST7NevGCiWVT+o8yptal+hc
 0vnD8XIcs=

=E2=80=A6
> Changing the integer to resource_size_t bar_size resolves this issue.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.13-rc3#n94

Regards,
Markus

