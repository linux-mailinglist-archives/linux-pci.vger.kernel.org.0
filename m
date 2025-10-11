Return-Path: <linux-pci+bounces-37838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8028BCEFEA
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 07:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C1BF4E165A
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 05:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C030A1D5ABA;
	Sat, 11 Oct 2025 05:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="UUBQXvQ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C8E1DF994
	for <linux-pci@vger.kernel.org>; Sat, 11 Oct 2025 05:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760159607; cv=pass; b=jz6OzhpZMmj1hW8B1tsDnSPMZUJyXe/LYYeXQC0wVoDkeuK27USrq50u8YfjcumWYA2wdpzWr2n5eDNqFvrjSjNhr5Sp0YZbeipEEftuEHRrGljr6aHbdwdUw1aGlg27snIN6IaoXxL2EX4a7RFA9Dffj14c1bRhXLo4w7w28HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760159607; c=relaxed/simple;
	bh=9BhZqDxL0VBy5/4SWaoiIg2QOjo7PZTlbbhg5oqhUjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZvOOjAA76he3jRpzivXJPHyRVEMj/t4T1cP7D4l+FFJy559wGH71uAl71rSmjHxtTh39/EB2mLAvUcM4dDe+pV2mi+aQcgLgltRugb8FNhYMTOTx8B4SmKXOw9QeC1RI2RpnqFJ91NnTpDmmpOPbS6h2xTlJynegT0s/YxZviw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=UUBQXvQ0; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760159571; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=srL6GbwiSbtfBsVLH6+FUznb4pLOsjS9BGjx0pnXH8TGQSxUvxiSid4irc/WHu1oPB
    ibEMsfDkfUvnZU7q4one+1Em14UErIKbEre//1uqRcfK/q9ruq/+7dMUzBNXG9+1fFgk
    L0cRbM9YHsM2u0hn6Sbb/fBmztaq7MOSDmKpj6bgvkw5NOJUsc6tEMezFt/nz/zR1fal
    NC9Z0yLf2Mj9FR0MCqW3GuI2ejdWx8VEPSucnK3iluwseGxoJ/F+LcCdtmidbq/8QU28
    jJKoyWGR1GtYqWYDTAHSUEZtl6IQibYmZWlGA7FpUTWH5zpuJQWbI997+ZGO5zUz1p8Y
    6DYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760159571;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CueFFfpjBu04D7vogLYnYo/zMgNC5D9Pphjzbi9BwDM=;
    b=B1/khlUp2xmbKQ/9IKs01S9SqW0qXmB3Rlw9q/JRw3l//ABF94S5Rdb6R/pVm5gE5x
    gvNfsBoSRmhA7lvO9ptY2SM4Q3OoTXUqjjBRsfWzgG1OsT5fCaQl1zQQSblHCFmtyplj
    d+FEUWXqFq3iecVoi0i3aYlqEFgKsF8txe8sTkPmxRHs2rkNl8Yp18qVaYor8vYgUt0Z
    0coK3yzbPlShfpIfWmBp8u7LV6Xez53RNIiYRwrJVv0u17XYIo0xNWdtynSwT4F1claR
    zyr1mf1qIc6R8QEjga20BCUhpFIpKub/OfVXq8u9uQ4c4wsuk6Jza2X9+hAWB9yMzmh6
    QqXw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760159571;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CueFFfpjBu04D7vogLYnYo/zMgNC5D9Pphjzbi9BwDM=;
    b=UUBQXvQ0D4Ng8LDUz0wLNHYgs2KTNSf9sa6TK5t33K7Ch9FUK76hem+T1fAVG4Besu
    6b6qk4XsvRdZLtrSr2WBYk4UycU8fYV7SNLI2tvGmL9W9D7YmW6KLrQtu57CQNAysKUC
    REDWiAmuxM2h7GuMjJB8rCgXtQPOPm9KByRI2/Oh/yPxbD8ztO3k5oCURSRLDbX/KnIF
    rRc+95dNqrRbZcJy8bEy0oq4+GM5MnEggmX5UXaQhuOykqd186YHDZE9uIYYalWvrgh2
    N4mwGFE0hpmDlt/8JSRcGUlp9GaVkseIJ7OxEjwxxl4fRfrcVRaW9wakm6sDunNoHF3X
    SOdA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+l6RLg"
Received: from [192.168.178.48]
    by smtp.strato.de (RZmta 53.4.2 DYNA|AUTH)
    with ESMTPSA id e2886619B5CoDjB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 11 Oct 2025 07:12:50 +0200 (CEST)
Message-ID: <d89576ac-c34c-4832-b51b-cf6f60c5c85c@xenosoft.de>
Date: Sat, 11 Oct 2025 07:12:49 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
To: Lukas Wunner <lukas@wunner.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>,
 "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
References: <20251008195136.GA634732@bhelgaas>
 <bf9ca58b-b54a-42fc-99f7-4edaa7e561f3@xenosoft.de>
 <aOdKAp8P0WwVfjbv@wunner.de>
Content-Language: de-DE
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <aOdKAp8P0WwVfjbv@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09 October 2025 at 07:37 am, Lukas Wunner wrote:
> On Thu, Oct 09, 2025 at 06:54:58AM +0200, Christian Zigotzky wrote:
>> On 08 October 2025 at 09:51 pm, Bjorn Helgaas wrote:
>>> On Wed, Oct 08, 2025 at 06:35:42PM +0200, Christian Zigotzky wrote:
>>>> Our PPC boards [1] have boot problems since the pci-v6.18-changes. [2]
>>>>
>>>> Without the pci-v6.18-changes, the PPC boards boot without any problems.
>>>>
>>>> Boot log with error messages:
>>>> https://github.com/user-attachments/files/22782016/Kernel_6.18_with_PCI_changes.log
>>>>
>>>> Further information: https://github.com/chzigotzky/kernels/issues/17
>>> Do you happen to have a similar log from a recent working kernel,
>>> e.g., v6.17, that we could compare with?
>> Thanks for your answer. Here is a similar log from the kernel 6.17.0:
>> https://github.com/user-attachments/files/22789946/Kernel_6.17.0_Cyrus_Plus_board_P5040.log
> These lines are added in v6.18:
>
>    pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
>    pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM
>    pci 0001:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
>    pci 0001:01:00.0: ASPM: DT platform, enabling ClockPM
>    pci 0001:03:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
>    pci 0001:03:00.0: ASPM: DT platform, enabling ClockPM
>
> Possible candidate:
>
> f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
>
> ...
>
> Thanks,
>
> Lukas
Hello Lukas,

After reverting the commit f3ac2ff14834, the kernel boots without any 
problems.

f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for 
devicetree platforms") is the bad commit.

Thanks,

Christian



