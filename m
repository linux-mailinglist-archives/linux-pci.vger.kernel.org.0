Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B6774403C
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 18:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjF3Q6g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 12:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjF3Q6f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 12:58:35 -0400
Received: from witt.link (witt.link [185.233.105.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A673AAF
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 09:58:33 -0700 (PDT)
Received: from [10.0.0.117] (p5489d081.dip0.t-ipconnect.de [84.137.208.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by witt.link (Postfix) with ESMTPSA id 212892A12A6;
        Fri, 30 Jun 2023 18:58:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witt.link; s=dkim;
        t=1688144311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikxJ1Dr9pCYWzRmhN1INQm/gS9slTBtm40yYy4EzVFc=;
        b=PMhzivQwXaUWdxmFX3Mj7qrZT2+OtR7Xxs0uf6p8Nm1D/tixlKvVxqPmfoUe89Rb5QCm9C
        3Ei5VBSjnI/wG/mjVaXT+mP+qvWAaIEEJTjxtNBIw4It3CSz0p038GIpZ8kZEmK4+V4ezK
        pqQsixs33W1MWPPv3xYP+O2or9wdc5LrCSivOGxgfgCCd3iZ4wiSEZwPMVDYnZYjZ7/n1W
        Zn3XUmwsMd+C041h99XV4uRhc7gEOaIdzTgt/6TOABchRxHcLjuh54YhNxXglqjHrgaqey
        opmvHDd2c5KlXau/87ByXdhl6HyGYbFX+SZuahLtuQGHwHyqI78zaOvHbsAnLQ==
Message-ID: <7efaf5d9-9469-9710-8a04-1483bc45c8b6@witt.link>
Date:   Fri, 30 Jun 2023 18:58:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Cc:     Thomas Witt <kernel@witt.link>, Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
References: <20230627100447.GC14638@black.fi.intel.com>
 <20230627204124.GA366188@bhelgaas>
 <20230628064637.GF14638@black.fi.intel.com>
 <650f68a1-8d54-a5ad-079b-e8aea64c5130@witt.link>
 <20230628105940.GK14638@black.fi.intel.com>
 <4b47ec58-dc34-1129-4a50-baf2b84b0f53@witt.link>
 <8af8d82dd0dc69851d0cfc41eba6e2acb22d2666.camel@linux.intel.com>
 <20230630104154.GS14638@black.fi.intel.com>
Content-Language: en-US
From:   Thomas Witt <thomas@witt.link>
In-Reply-To: <20230630104154.GS14638@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/06/2023 12:41, Mika Westerberg wrote:
> @Thomas, below is an updated patch. I wonder if you could try it out?
> This one restores L1 substates first and then L0s/L1 as the spec
> suggests. If this does not work, them I'm not sure what to do because
> now we should be doing exactly what the spec is saying (unless I
> misinterpret something):
> 
>    - Write L1 enables on the upstream component first then downstream
>      (this is taken care by the parent child order of the Linux PM).
>    - Program L1 SS before L1 enables
>    - Program L1 SS enables after rest of the fields in the capability

Sadly, same as before. With s2idle, power consumption stays up, but 
suspend/resume works, with deep it does not correctly suspend the PCI 
devices.
