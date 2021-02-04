Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BBB30EE8F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 09:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhBDIgO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 03:36:14 -0500
Received: from halon.esss.lu.se ([194.47.240.54]:39193 "EHLO halon.esss.lu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234982AbhBDIgO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 03:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:to:subject:from;
        bh=kWa7eRyWY/ViKBH5Dz8k0xhlfT5+/t8NeCDDCY/ZZOU=;
        b=QfpU2fVlT4YIAY8ZYFdgR4DiuLoE8szodQk8Xf2hRYEh/arrsL2RtBkjXscn4UzbNzdCbJ5MEovUJ
         CPWsmJm+ZnV2hycZgYlnbUivN1WSL9iCcPpKBkUrusk+ReNft7/KeB+K4tS3ZAENRE2gdLzbmE5gg1
         F3+kxyk0j+IKh5NWtP0s5vh/x+D+WwCIB3DUrzRCcQcTK0fsozkT8v14SAaIaZDU2e8PTFSVMYEaFF
         Y/emJ6OVbKZ9Mu/z6woRMGf9sa/MRG1E4BhaLVCsptLCVRZdgAmtMSkFHTeNQtSBCDJ/3KHh4o0fPb
         xuTmwswAopCove+SMsQjucfoBHZE1Nw==
Received: from mail.esss.lu.se (it-exch16-4.esss.lu.se [10.0.42.134])
        by halon.esss.lu.se (Halon) with ESMTPS
        id f11634fb-66c3-11eb-93c8-005056a66d10;
        Thu, 04 Feb 2021 09:35:31 +0100 (CET)
Received: from [192.168.0.6] (194.47.241.248) by it-exch16-4.esss.lu.se
 (10.0.42.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 4 Feb 2021
 09:35:31 +0100
Subject: Re: [PATCHv2 0/5] aer handling fixups
To:     Keith Busch <kbusch@kernel.org>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20210104230300.1277180-1-kbusch@kernel.org>
 <20210203000320.GB22815@redsun51.ssa.fujisawa.hgst.com>
From:   Hinko Kocevar <hinko.kocevar@ess.eu>
Message-ID: <24132ba1-08de-b5c3-0a97-b1236a6131f4@ess.eu>
Date:   Thu, 4 Feb 2021 09:35:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210203000320.GB22815@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.47.241.248]
X-ClientProxiedBy: it-exch16-4.esss.lu.se (10.0.42.134) To
 it-exch16-4.esss.lu.se (10.0.42.134)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2/3/21 1:03 AM, Keith Busch wrote:
> Hi Bjorn,
> 
> Any further concern? I beleive Hinko idenfitied his observations as
> being solely due to his platform rather than this implementation, which

True.

Thanks,
//hinko

> should fix some outstanding uncorrectable error handling. Please let me
> know if there's anything additional you'd like to see with this series.
> 
> Thanks,
> Keith
> 
