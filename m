Return-Path: <linux-pci+bounces-37849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF1FBD0070
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 09:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7319B4E12EC
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 07:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572CD21FF29;
	Sun, 12 Oct 2025 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="AqlMkZ04"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5081400C
	for <linux-pci@vger.kernel.org>; Sun, 12 Oct 2025 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760255603; cv=pass; b=sixWDstHIywHkywzWsqIXBBme7fZjWaVQam+4YWs1IYBxN7lZoravy5MNES7Hm4bp+GXjrAy8bFkcQdv6pBrMzlKFyJ0UVTp/bKyzYWQ9YvkzGgHWjsKBB+jzXSBU2v27ruxRWemJcTOVoik08yICJozgiGtPDI0a6HFYZbaE8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760255603; c=relaxed/simple;
	bh=6/9AH1c4i83b+7Km3Zc49MWAJxtzgGxDEQWvwIAC4b4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=k74wRiDuxxSAgKOHx/zazu2JLmYyvV3mgTO3qvHvnp9UgDMkMn2Wx6nXTD2rzpHRP8/WROlcuaSjy991xO+T/HQb50I74Ifk5+Ir0t5bis9R9V9rCF/9byjSuTFw7vwmR0t1kG/HBjqr7TBkj77jEJqx6QwAik8240zy3Uk0+RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=AqlMkZ04; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760255236; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jCPGN0wSzOvIFAcHgRB/NvFUUO8Ku/UTye3Vrnv0ZgeSFNJVkDpql006xOmjN8EuqP
    DqeZK1x7yL1YMnoaN9Twfey+jenrsYqtRNwPhRCuObs5RAiqOexRZgiaAHGqK43BC4Yi
    OLi8yU6rmk5CGNfz9XO4/UFqEL8Sqw9xhGl6O0bTIGJy8GjxiFGX/wW/hTCK27fUNaJm
    eMJ28/qINrS/kzFUugQb3inA3GoeLc5uyXVHPCtERnGbYcC0RNxG1ENVPVA6Ai7+MQoI
    /NUC+ou9soFrx+28jJbsHqVFe3fW+7JtvPY7JCLKcVU3rCwLaWSE/nSskuMKl7aQq6ov
    0fng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760255236;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YJv1nwlpb1FE3XNGlM26PFKd0Hvc2WtDFiInGBfhNoM=;
    b=NVKC4w60vXO3wJ5yZs91qX8GrOwiwqV8PC1rmSYYnVxwDBvAU6lUrSSUQnUGxuk4mD
    oBIVOoYeE7yWd7RXyvYSdJHBCGa5BTLFxGx9/hbDvMXoczxl8s0HSsZBWVXn42pWLJvI
    X0OsUv8MlR3M/r64GB138Sih9Y8j4GZgSfMzmL682NcmGH/B2A5qXD5a7EHWUW4SY0uj
    43wUbKNyZKaLLpZF42/wYhWCHhxKzSzeAS8PGkCN9xcj1AaPATwjUCVrYxEbOkHuzOhl
    HhoRRnPMibjVmwCbJ+X1If0vxpmm2R7Kcc6Nx/Jc9/10+BkULjW891tHyxhh8zgKmU4w
    vYtg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760255236;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YJv1nwlpb1FE3XNGlM26PFKd0Hvc2WtDFiInGBfhNoM=;
    b=AqlMkZ04GST4rXRXL/7c/oLwVo4rz8GDMnuy0pgdT1DcZ91Li/isofeLrIzdF2KHFP
    h643wl3yFGZHZ3Xek0MmUMNg72c5NeRBU54dmbq71YEibl6pslJatkC6906g34Olh+C4
    aM1hlgJa5Y3vBYG980rZI3X7Duj9yPTA/BahnP6WVkdrhVpRA1OCxm2HHYMU0iVahCfZ
    MyKbisf83q/8csdehDe6VbyGpZbvDXHol07s+apVxwrg9l1V9AgzPCjf8MvV9mLwWJCA
    2DYlivcFtZfp86MDkd4WHUi6a9G7SV0tw3SmBOcCMsmYyPGgpCYyHeFSTki3QrGLLHa7
    ae0A==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+m6Xc="
Received: from [192.168.178.48]
    by smtp.strato.de (RZmta 53.4.2 DYNA|AUTH)
    with ESMTPSA id e2886619C7lFIMI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 12 Oct 2025 09:47:15 +0200 (CEST)
Message-ID: <6ed8f4f0-8c8f-435e-a8df-2dc51773d9fe@xenosoft.de>
Date: Sun, 12 Oct 2025 09:47:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org
References: <iv63quznjowwaib5pispl47gibevmmbbhl67ow2abl6s7lziuw@23koanb5uy22>
 <10994220-B194-4577-A04B-EBC5DF8F622F@xenosoft.de>
Content-Language: de-DE
In-Reply-To: <10994220-B194-4577-A04B-EBC5DF8F622F@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11 October 2025 at 09:34 pm, Christian Zigotzky wrote:
> Hello Mani,
>
>> On 11. October 2025 at 07:36 pm, Manivannan Sadhasivam <mani@kernel.org> wrote:
>>
>> Hi Lukas,
>>
>> Thanks for looping me in. The referenced commit forcefully enables ASPM on all
>> DT platforms as we decided to bite the bullet finally.
>>
>> Looks like the device (0000:01:00.0) doesn't play nice with ASPM even though it
>> advertises ASPM capability.
> It’s the XFX AMD Radeon HD6870.
>
>> Christian, could you please test the below change and see if it fixes the issue?
> I will test it tomorrow.
>
> Thanks,
> Christian
I compiled the latest git kernel with your patch but unfortunately it 
doesn't solve the boot issue.

