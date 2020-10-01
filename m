Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8963327F8F9
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 07:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgJAFQk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 01:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAFQk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 01:16:40 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D27EC061755
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 22:16:40 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k25so3392255qtu.4
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 22:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aMyvN3gVuzQBj94keSmCrKk4OuJZbSTTfVDU0BztZ4o=;
        b=AVGBn0+Y6owZXBJwfgazLUzFbjbqhVCnIW+1imTfPSnAc4qi7Pe58QXALxxfEHH7NW
         Vmy+eT2KQGF2AIMXrNIMHPa8N03xNcPDw1BysPzyTAUnBrmDwNyfA8Z7LXmyUYQd1/o8
         RydFp/NoH40fXqP4HLKbi4+nTGK9g3eJjstINt2w+IXfYYh/n6Gm9O/c2LARTFTxC59L
         GmDP40ZpueoCjSn8apq2cXt07EwlpZAZGW7F+u1qOCjoBxwIEqelJpxSQL9IZ5Yl2Uzc
         PyR3L4tECMB7sGhVLpgOoE5R8eq3RouzGk215efLgIqDOVkjiJNv2shFlT1s4Vagg/xo
         8xMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aMyvN3gVuzQBj94keSmCrKk4OuJZbSTTfVDU0BztZ4o=;
        b=Bi2/ZUu/X+IT779j7Q7ZW41yKsWHgb++Uth1ExMLKlpo6bo8TrVC/OPQTW2r3aSUuX
         zTLwRJabuVBWjIHS9+ZFVLZDemdKOkm8pYvoNyG+1V9NnR7Ei6LCVmd9xK8aTxiOHfKK
         S+OUl+LsJtP/tgHZJHADuil0Mv/8Z2Zqb6PBSbZrwyLwnxywEfP95vQc78jPc6c4Z7CA
         15tJjeCkxz21zMtkZNbeLWb4WTHZ6n7WlaXscXATilr4ePDFCeqWQM8io2v4gvu8Ob6X
         ewmrfyUDSFGzCcjuAXE8RptpucOQd1yYvJiXmBBzUtpVBvYzLc5+rLAypu7Nz++ep3oa
         cdAg==
X-Gm-Message-State: AOAM531odLvjkr9HZj5nuorugVU90tvVA5lrM0xBC0lnA1sTplJeSvWK
        C0nI17BrDT8HEJCVkU+P5iZJhg==
X-Google-Smtp-Source: ABdhPJycizkFTjy7tefZlHhV/5gxSPPlo5/jlzPCRbOXkxTOJNHO7ZWBwNjJw8GrRDEREZvf+fBRfw==
X-Received: by 2002:ac8:4442:: with SMTP id m2mr5933638qtn.73.1601529399269;
        Wed, 30 Sep 2020 22:16:39 -0700 (PDT)
Received: from independence.bos.jonmasters.org (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id 16sm4944270qks.102.2020.09.30.22.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 22:16:38 -0700 (PDT)
Subject: Re: dma-coherent property for PCIe Root
To:     Valmiki <valmikibow@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org
References: <1512d7b5-54c6-3b87-0090-5e370955223e@gmail.com>
From:   Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <269995f2-d57b-d218-8730-fe729cc9dec2@jonmasters.org>
Date:   Thu, 1 Oct 2020 01:16:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1512d7b5-54c6-3b87-0090-5e370955223e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/14/20 1:23 AM, Valmiki wrote:
> Hi All,
> 
> How does "dma-coherent" property will work for PCIe as RC on an
> ARM SOC ?
> Because the end point device drivers are the one which will request dma 
> buffers and Root port driver doesn't involve in data path of end point
> except for handling interrupts.
> 
> How does EP DMA buffers will be hardware coherent if RC driver exposes
> dma-coherent property ?

This simply means that the RC supports maintaining coherency, it doesn't 
mean that the RC driver does anything. It's a property of the hardware.

Jon.

-- 
Computer Architect
