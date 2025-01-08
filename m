Return-Path: <linux-pci+bounces-19515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A031EA0551A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 09:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025F13A2C71
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681751B3938;
	Wed,  8 Jan 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CBHo4mNZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9881A9B48;
	Wed,  8 Jan 2025 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736324061; cv=none; b=XIzdL6OV/m8qUxk5Fpnom6/xQRLan2uLUflJdkfklB+GZzvYB2kqwfKACFrUDtLt+6wrU/KD24rL3Sj6BdCtz6EgcwjxiLpKEmh2H8gAwW9qLmq7lz0j6JPk0R2ghUzg9cVkMMklEHmEoTDAw6NztrtWUNRoaE+RFeD60Dh67eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736324061; c=relaxed/simple;
	bh=D+6socFPmFuEzAzkF/8UlWOe4yBXrRw2COpcBgf6src=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9vtsDMOF0bj70PK3h/Ad8rmirkUR3mT0tM1GPIa45kcn46+2BYGqmvSYU7Sz2odaslNOZrwkZlxbZoeXOoiAh6kONVSUrmAC4BST5R8Q79BCIH+neEvUZRDJbwaLFn6p3FzV+1Kg/Hfd4YqfpsRiyVi3R3T8wm+w/e4uVKJqgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CBHo4mNZ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=D+6socFPmFuEzAzkF/8UlWOe4yBXrRw2COpcBgf6src=;
	b=CBHo4mNZPbBcI9b7imEMIDe1EcYwl1JojxBpfZ9Enh2FEUNd/W02R4bGnzP7e5
	y0TfPX4aD13YCzxYUQxwuu4cd4JTyGjpAon9e+yWQk+APsb7/EnXXePzIvnHVpoy
	YKq1C9ftgZyD9/MJqcd1MVIoq4V2RNy6vIOoejlUwY0Io=
Received: from [192.168.174.52] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3f6NlM35nlmSrEg--.7880S2;
	Wed, 08 Jan 2025 16:12:22 +0800 (CST)
Message-ID: <d0a658ee-c715-40c4-9eb9-0475063e72e9@163.com>
Date: Wed, 8 Jan 2025 16:12:20 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v9 1/2] misc: pci_endpoint_test: Remove the "remainder" code
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250108072504.1696532-1-18255117159@163.com>
 <20250108072504.1696532-2-18255117159@163.com> <Z34r44ltlzRhatyg@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z34r44ltlzRhatyg@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3f6NlM35nlmSrEg--.7880S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3yCJDUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxfOo2d+KwjoLAAAsL



On 2025/1/8 15:40, Niklas Cassel wrote:

> You also need to remove the remain variable declaration in this patch,
> otherwise there will be a build warning when building this patch.

Ok, I have resubmitted patch.

Best regards
Hans


