Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732B04CD61B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 15:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiCDOQK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 09:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiCDOQK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 09:16:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6C5D2DD9
        for <linux-pci@vger.kernel.org>; Fri,  4 Mar 2022 06:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646403320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bGymhB6617r1a5UtR5SmVs04n4Hj/5Nxc0lgsmBP4E=;
        b=H+raRbN+AMIsMdPwuxDAm48pRqQXjpeVnlsvm5ZIDsSMSqvyThkgxBCS31gNRCniUr7ro0
        48aRGK0LQBE4B3kT4dNxAojKasR+PJNNqpXhNv4BcBBesdbChMcn0OMtCkP0ZbKR0dkeDO
        WMGBrIZJMxyjTK5R38xn22Q82gWQhig=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-qv336blzOUiQ2mbPMfEYbQ-1; Fri, 04 Mar 2022 09:15:19 -0500
X-MC-Unique: qv336blzOUiQ2mbPMfEYbQ-1
Received: by mail-ej1-f70.google.com with SMTP id og24-20020a1709071dd800b006dab87bec4fso1017388ejc.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Mar 2022 06:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/bGymhB6617r1a5UtR5SmVs04n4Hj/5Nxc0lgsmBP4E=;
        b=Qncpc/Ks/mFZhQxps3r5LPo06SfYFphq8M5dE79smGrZNMLc391W2XhqewXkvi2EnS
         YbSAbV46QwNJTip2sADS7EKQwBvDRjlQNM995XEupT5ck8ehBVdUPWVpdS7xe2QtR7qD
         OvavWXgqhoZVgt9rt714JElVsgF9cS2uuibLS3wRC+dqBxQJLBXCHQHRzSJHZndAV1bT
         i0PRd8yDkCxBuEE1M3D1lJfSPE9yI5QEgp8xsOOXn1rTE7hGfMbqnbIXUDxsdBOXlvIV
         RN/AkVhZ/tywi2dHh1xlGqcc5+SyLJl6GcIqx1s0Ty+P+CjFka8gEVPSGi//ausVq2V0
         xFxw==
X-Gm-Message-State: AOAM533D+Xhf+wtnfJPhtQxuLU+/YC87uocMvflESa9/wvGTrpxptinp
        PB27hUFX/Jdc30Pv5mCdy+diqMJBpV7fFo5orc8/uLH3QzAekP4775JNxeUTHwAKa52EkvEjwLf
        ztwBHXeIzIrxxh7LLhisr
X-Received: by 2002:a17:907:a0c9:b0:6da:9614:2626 with SMTP id hw9-20020a170907a0c900b006da96142626mr5831166ejc.100.1646403318292;
        Fri, 04 Mar 2022 06:15:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuq8suB3cekzKdmKk+8QL/Qxz4QVcdLRr5yO92DMAEEF4jcJL9bcL7SgOMYa4YtQzq1wpoMg==
X-Received: by 2002:a17:907:a0c9:b0:6da:9614:2626 with SMTP id hw9-20020a170907a0c900b006da96142626mr5831141ejc.100.1646403317995;
        Fri, 04 Mar 2022 06:15:17 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id da19-20020a056402177300b00413583e0996sm2124494edb.14.2022.03.04.06.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 06:15:17 -0800 (PST)
Message-ID: <4836963c-7a1e-7452-eb88-454f2b75e407@redhat.com>
Date:   Fri, 4 Mar 2022 15:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 0/3] x86/PCI: Clip only partial E820 overlaps
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220304035110.988712-1-helgaas@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220304035110.988712-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/4/22 04:51, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This is based on Hans' extensive debugging and patch at
> https://lore.kernel.org/r/20220228105259.230903-1-hdegoede@redhat.com
> and applies on 7e57714cd0ad ("Linux 5.17-rc6").
> 
> This is basically the same idea (applying the 4dc2287c1805 workaround only
> when an E820 region *partially* overlaps a host bridge window), but I think
> it's a little simpler.
> 
> This also adds a little dmesg output when clipping, which should make
> future debugging easier.
> 
> I bcc'd several folks who didn't have public email addresses in the RedHat
> bugzilla or Launchpad.  If you review or test this, I'd be happy to
> acknowledge that.
> 
> Bjorn Helgaas (3):
>   x86/PCI: Eliminate remove_e820_regions() common subexpressions
>   x86/PCI: Log host bridge window clipping for E820 regions
>   x86/PCI: Preserve host bridge windows completely covered by E820

Thanks, I agree that this is better then my fix I also like the logging
added to 2/3 which lets us know if the commit 4dc2287c1805 workaround
is active.

I have one small remark on 3/3. Regardless of that getting addressed
the entire series is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I've done a Fedora test kernel build of 5.16.12 with these 3 patches
added and asked the reporters of:

https://bugzilla.redhat.com/show_bug.cgi?id=1868899
(ideapad touchpad bug)

and:

https://bugzilla.redhat.com/show_bug.cgi?id=2029207
(Lenovo x1 carbon gen 2 regression with my bios-data based fix_

to test the rpms and to collect dmesg. On the X1C2 this should show
the new logging from 2/3 "in action" and on the ideapad the touchpad
should still work...

Regards,

Hans


