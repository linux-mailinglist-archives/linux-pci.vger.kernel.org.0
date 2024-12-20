Return-Path: <linux-pci+bounces-18828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E979F8A79
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 04:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089591668CA
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 03:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728BD4EB50;
	Fri, 20 Dec 2024 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O/UprYs0"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B00C4D8CB
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734664232; cv=none; b=cLfjrkmhgFxDoT6greKF97N2SNm0sOKt/ZAgAOjQEroXMoCqa7oGCRi6rUb1X/dxfETkJsMVkArwrPY4FWxdgWq3eMKa5uqdWgWxPCWJkyO2qcbfzUyuf3mZkgRDcip7/HqdSOKsjvULJLgBQFW4GJiP+syn5qAecRkVinsVFT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734664232; c=relaxed/simple;
	bh=aMIpDQlTd/isxVtsY1FjgYYn8DrP5OWoYCEs1bnIYGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TX4zlqFHaL8aVIHOnA5TM+uWFEdiwk1hxRpNRS2TEXiW60uss3tIfBcgmN855iLAgTwCByC5KG6AY/Lne/TUqz5S9J5FrFGKCAYLctzRNUM4TafVvRcEzJfDUkGaNDAin4ia1OaOUWmBNhFQvpDHDghO82oNV60DA6c4OJKIJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O/UprYs0; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=ulziWKnJfzHnjk7hS3vUulFgPqfYTN9BLXYnZPlXYqk=;
	b=O/UprYs0QTZ5ZZ34LblLgEqatweOirlCdr54HQctY61+8GBODD95R0e55vcqvl
	AsrIt9dQYmpcguwD62kFsMqBw/Iib2r5GzRMz+uIAO9Z4/JrAGyOJZ2QZdQfjcfU
	9s0scOqsy+VLJT9QrLbgjA+bHjx9OzmS23Q5hm/R6Ov/0=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wA3Vvn732Rnry54AQ--.22052S2;
	Fri, 20 Dec 2024 11:09:49 +0800 (CST)
Message-ID: <77103dc1-e131-296a-4f38-668c1ff84afb@163.com>
Date: Thu, 19 Dec 2024 22:09:47 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] misc: pci_endpoint_test: fixed pci_resource_len return
 value out of bounds.
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
 arnd@arndb.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-pci@vger.kernel.org, inux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20241217121220.19676-1-18255117159@163.com>
 <4ed0496c-329b-ae7e-dce4-5d822e652d46@linux.intel.com>
 <ca7e3d52-c60d-ee19-ca6b-8fa5674197c2@163.com>
 <fcac2f00-3d68-a398-4d47-2858272849f8@linux.intel.com>
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <fcac2f00-3d68-a398-4d47-2858272849f8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3Vvn732Rnry54AQ--.22052S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU6cTmUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwu7o2dk2XjOWwAAsr



On 12/19/24 07:36, Ilpo Järvinen wrote:
> 
> Yes, when you change the patch in anyway, please create a new version.
> 

Thanks Ilpo Järvinen for feedback!


