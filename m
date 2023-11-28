Return-Path: <linux-pci+bounces-206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED19C7FB1DA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 07:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B591C20A55
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 06:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4970111CB1;
	Tue, 28 Nov 2023 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ARfjCT2z"
X-Original-To: linux-pci@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7815C4;
	Mon, 27 Nov 2023 22:14:35 -0800 (PST)
Received: from [100.124.219.30] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 0511B66072A4;
	Tue, 28 Nov 2023 06:14:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701152073;
	bh=ZG0Tm8rmeYeyaVrNuXAmLFqred76mjRjFtnoj7e50pc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ARfjCT2z30i9fMFc6uRARQ/ghAqWw4A2tIgSIb9WZ6Tjo411B4URSZP0mgHsu/rdv
	 iti4J2nZMLwPI1R4S8ZpuxTPMFs7LFlGn77OoxO5JQitCNI4VRKbho9RLqPN5eOpiH
	 kkrj+7yDHLMydfsb6QfXuuGUBivkzDe1RuU7bcEKYPi+FFFqiM0A7TORq0WlqkMbFr
	 KFyyMTKs97wP8t2fa3L/mItY5ZsmROhydQRASx4nh7Jr5YEXIfWi9ZbVcsM/oJvFkO
	 4lJGtp6uWQqY86UdD2EfTjIsiNGyhvnOT76+Csksn34xbEmzSC+cCuLlun0VGVp6rj
	 cYBam44Q0sE8w==
Message-ID: <50a9f061-e1d3-6aca-b528-56dbb6c729d9@collabora.com>
Date: Tue, 28 Nov 2023 11:44:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] PCI: qcom: Fix compile error
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: intel-gfx@lists.freedesktop.org, helen.koike@collabora.com,
 daniels@collabora.com, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231128042026.130442-1-vignesh.raman@collabora.com>
 <20231128051456.GA3088@thinkpad>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <20231128051456.GA3088@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mani,

On 28/11/23 10:44, Manivannan Sadhasivam wrote:
> On Tue, Nov 28, 2023 at 09:50:26AM +0530, Vignesh Raman wrote:
>> Commit a2458d8f618a ("PCI/ASPM: pci_enable_link_state: Add argument
>> to acquire bus lock") has added an argument to acquire bus lock
>> in pci_enable_link_state, but qcom_pcie_enable_aspm calls it
>> without this argument, resulting in below build error.
>>
> 
> Where do you see this error? That patch is not even merged. Looks like you are
> sending the patch against some downstream tree.

I got this error with drm-tip - git://anongit.freedesktop.org/drm-tip

This commit is merged in drm-intel/topic/core-for-CI - 
https://cgit.freedesktop.org/drm-intel/log/?h=topic/core-for-CI

Regards,
Vignesh

