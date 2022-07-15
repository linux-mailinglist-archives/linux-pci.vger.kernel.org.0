Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB15766CD
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 20:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiGOSdz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 14:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiGOSdx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 14:33:53 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7484EBCBA;
        Fri, 15 Jul 2022 11:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eHY8ml2kSNhWyc+Lu2y+Au3hBhDY7pHCci4IztLK7Xc=; b=T+0xYXeuOGrOK3gFQFS+sISKGh
        SDcLCeRHEaBPMmX4jDC7KMCJofTE7poUJ25T5Hm5Ghl3XGw6nWsSxelviFUhyN/YlhEzgdbj9f5ih
        olPqVatvSPG5Sc5rZOo06VaWxw6lfj5ZPP2fOAW/5wgVOWaCaY7QSOji3e0Qu1oz+DbUaxNRgKbRX
        OaOi/f4vU6kiIXqyJ6eCFVFPeLdxxNLk85+O8x5Zq6ixFC3LSE6iIyVwm4PBNS/iq6PyHxOWoKS08
        78UnOdFJvuZ13GZT2WXs5AF/18wy9kkVeN0xISlEW/m+DNkWZsbGzOvzLmQUtEjf+9+Rawd9DEcgE
        AMaaI8/w==;
Received: from 201-42-109-188.dsl.telesp.net.br ([201.42.109.188] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oCQ7j-000aT2-DH; Fri, 15 Jul 2022 20:33:12 +0200
Message-ID: <15432ee0-3a33-0b53-b39b-f8b53a7e4345@igalia.com>
Date:   Fri, 15 Jul 2022 15:32:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] powerpc/pci: Add config option for using OF 'reg'
 for PCI domain
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Guowen Shan <gshan@redhat.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220706102148.5060-1-pali@kernel.org>
 <17fb8d12-60f9-09d5-91fa-09d5a5a9a4fd@igalia.com>
 <20220715171132.ujaexzm4ipad7o4f@pali>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220715171132.ujaexzm4ipad7o4f@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15/07/2022 14:11, Pali Rohár wrote:
> [...]
>>
>> I found this sentence a bit weird, "in the similar way like it is doing
>> kernel for other architectures", but other than that:
> 
> If you have some idea how to improve commit description, let me know and
> I can change it.
> 

Oh, for example: "in similar way the kernel is doing for other
architectures". The sentence idea is perfectly fine, it's just that it's
a bit oddly constructed IMHO heh

Cheers!
