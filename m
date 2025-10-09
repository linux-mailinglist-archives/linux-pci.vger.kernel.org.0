Return-Path: <linux-pci+bounces-37748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C1650BC7645
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 06:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7481634C5FB
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 04:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA3325B687;
	Thu,  9 Oct 2025 04:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="qbij8MxK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F5C25B311
	for <linux-pci@vger.kernel.org>; Thu,  9 Oct 2025 04:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759985735; cv=pass; b=PgPpruVICsIAKVYFvt3bMrJweTBlPlJfO5DBbFe+UV3AdDOF7wgnHPf6Q+Ffa3nlXZv0HeNxvaYVdIFi516JiCH+YpwZDXSPG9WXSyxRs8qJl97Ozw26CykWQllnNbupehJV7csrNvx3ruQyPERSX3Y8+K9DzUADYx2gtlmQolA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759985735; c=relaxed/simple;
	bh=bDOrwCp4Jnxt7hI83nL1HrCLg9zeQ3XXud4Ki7k0dn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjeIv95mU5O25by2GV5QPYRPmqJhxXDgHIVDJe7B8wVHqd5R9JAnQGYIBG/CN+Xi8nCANwtwG2spoKutWCX416kYwfdZfdeeGI3slJ+btcDnJXmp8f1hMeRjApnCdbq9ylW9aXD1Y++WDFnwJz6BkL5VO4vQ7zUCqTniTMnnZpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=qbij8MxK; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1759985700; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=F56rCJ0q8954aZD94VJ7x27yd9u9Aj40qJVUQCOJOrn7NN79qIABhRLPUqiN/YA2l+
    00xiMNy2+y0/dEzseMe3h88j83UNm4CnM2ue4OLfJUjDto2neav8MyW6fym3KLKHLuLT
    3eODsQoMpDAQlTis3rr18EsSbFAPrMDEAbARDBVYufNf2R47OZN5pmFKwEiKzhIWL7rS
    YRFYx/nij/migaYjPs/k0lsKks67bbLsoGCeoVK+6igceW/o7PFY83CSdUmorkaevtR3
    wo57x6I6Ifr/IJhqG1Oc0951qWARrKxjUe4Os8RPfqbiILzcJBBLbOwTXgBygTxE8tgq
    r+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1759985700;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OX1tVNlrAcfa4iqVVPoLKKR8g4n/Am+5WfbaAXlKtTo=;
    b=swjNYCScNauh8GrYI/0/v2O9RPZ69vuX4M7qXdEpldyXGw0znTXajzCtPA7FZNrHUp
    yMKGAdxMtEzmEZ0Mou0hOmP/tBaCoWKd2hJQE3B/rckuhD8+HeNA4gAIgSkqgnOtYOIl
    YoiIFvmtSTEAw9knOqrS6bg2Fjygnb4GgvuOH0Hfjj/zal/4WBGOemat5mjEbNzLD2Pf
    IT0fosnoAcF5rdBrIm7+Ru6Xp175iC+MTzGvwd6IAwA86kTIYSf8PGnmJzcnlwAGIHpL
    UEFUjjOVk1hh+rY0fww/GKTMLdSYmQAFQpdGu8Kwkl8sPoljAR7QGCFr0uwg7i6AEkM4
    dQ0g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1759985700;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OX1tVNlrAcfa4iqVVPoLKKR8g4n/Am+5WfbaAXlKtTo=;
    b=qbij8MxKVR9tfg+gp5RzyF7cOdefyYKfKaqcsVEY5eK5cPXulA07H5Wj2ptFcfGU5p
    ADDMfjTJ7ng8340D4Ur9tZmB4MQVpw9dQ32wM3VvtX/4g6ggHTQ7RbxjpzFI39n/0ncs
    976yKUbBZNR7je1lCfY7LYAdTUG7ItEwRs0zMfM0EFZbJtEdNRYIWdwNcyDh4mckArjC
    ZjArxHVoDbl5jPZTItixFFV5jV2syfYfYP0RKvzBra0obS3E1rgiKLZfB7yO19ni+Snl
    QDkBXjf6TibuU+k5kVf1kLkdIgtDfwrefJmrudoolfBBKR2UNvo3fiC5GziH8S2NOjWW
    fsVA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+l6hjg"
Received: from [192.168.178.48]
    by smtp.strato.de (RZmta 53.4.2 DYNA|AUTH)
    with ESMTPSA id e288661994sx35X
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 9 Oct 2025 06:54:59 +0200 (CEST)
Message-ID: <bf9ca58b-b54a-42fc-99f7-4edaa7e561f3@xenosoft.de>
Date: Thu, 9 Oct 2025 06:54:58 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>,
 "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
References: <20251008195136.GA634732@bhelgaas>
Content-Language: de-DE
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <20251008195136.GA634732@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08 October 2025 at 09:51 pm, Bjorn Helgaas wrote:
> On Wed, Oct 08, 2025 at 06:35:42PM +0200, Christian Zigotzky wrote:
>> Hello,
>>
>> Our PPC boards [1] have boot problems since the pci-v6.18-changes. [2]
>>
>> Without the pci-v6.18-changes, the PPC boards boot without any problems.
>>
>> Boot log with error messages: https://github.com/user-attachments/files/22782016/Kernel_6.18_with_PCI_changes.log
>>
>> Further information: https://github.com/chzigotzky/kernels/issues/17
>>
>> Please check the pci-v6.18-changes. [2]
> Thanks for the report, and sorry for the breakage.
>
> Do you happen to have a similar log from a recent working kernel,
> e.g., v6.17, that we could compare with?
>
>> [1]
>> - https://wiki.amiga.org/index.php/X5000
>> - https://en.wikipedia.org/wiki/AmigaOne_X1000
>>
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
> #regzbot introduced: 2f2c7254931f ("Merge tag 'pci-v6.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci")
> #regzbot link: https://github.com/chzigotzky/kernels/issues/17
Thanks for your answer. Here is a similar log from the kernel 6.17.0: 
https://github.com/user-attachments/files/22789946/Kernel_6.17.0_Cyrus_Plus_board_P5040.log 


