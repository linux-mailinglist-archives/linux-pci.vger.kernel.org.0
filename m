Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89F06952AF
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 22:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjBMVHm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 16:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBMVHm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 16:07:42 -0500
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC811A669;
        Mon, 13 Feb 2023 13:07:41 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id b9so5523816ila.0;
        Mon, 13 Feb 2023 13:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wt9tOv5B7IbxTS12O/X2u6Lu0qxJXQBs+Cti6wqI6A=;
        b=YjO5ygybRFkcpqRK4vbRmKNtPzKlAJVsNW8vatpe1WwXnBY4U2t7d5ezAS7nPaAL4s
         2zJ3F6uaVdLzXR5wGPDmB7gDzVGjv0SwwPn1PnmdvInSheglR5X8xfn1fuGGDwnFqic6
         hchhGC7wsexCRT3msvgGtz01CuDbkCBYRe4UBk3JC+M5BuENVQExPI0vnF7tmdOhocen
         AOREEq/SCvdaUaRFDlQZu8iptFO5EtDtERWcND1X778lSNIPzKlmyhJ20pYcBWyvLVnU
         eyK8h7pPPzl8fjfN5H9vALQspK9h7V0n5Idd+37DckNAFz50T/mrVbAhM3kW/MujqY1i
         NAZg==
X-Gm-Message-State: AO0yUKVxvNLLcKQJRYtoNPloZDD8NiwSm1Obt2PJEXsPfA4Eopfh1+GH
        Xc5OcLAJQGOMb9OC+4Ylyhk=
X-Google-Smtp-Source: AK7set9lEQTT6SFAftlGraZqT416KXysD69KhzpWkDuO3H7clY9ZWx2SsMPXmzWafMnttFVjLdAsuA==
X-Received: by 2002:a92:ca47:0:b0:312:7a4e:e94d with SMTP id q7-20020a92ca47000000b003127a4ee94dmr234553ilo.2.1676322460765;
        Mon, 13 Feb 2023 13:07:40 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id t26-20020a02c49a000000b0035678e2e175sm4204906jam.50.2023.02.13.13.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 13:07:39 -0800 (PST)
Date:   Tue, 14 Feb 2023 06:07:37 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        steev@kali.org
Subject: Re: [PATCH] PCI: pciehp: Add Qualcomm quirk for Command Completed
 erratum
Message-ID: <Y+qmmY+At4eFg1Dq@rocinante>
References: <20230213144922.89982-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230213144922.89982-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> The Qualcomm PCI bridge device (Device ID 0x010e) found in chipsets such as
> SC8280XP used in Lenovo Thinkpad X13s, does not set the Command Completed
> bit unless writes to the Slot Command register change "Control" bits.
> 
> This results in timeouts like below during boot and resume from suspend:
> 
>     pcieport 0002:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
>     ...
>     pcieport 0002:00:00.0: pciehp: Timeout on hotplug command 0x13f1 (issued 107724 msec ago)
> 
> Add the device to the Command Completed quirk to mark commands "completed"
> immediately unless they change the "Control" bits.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to pci/hotplug, thank you!

[1/1] PCI: pciehp: Add Qualcomm quirk for Command Completed erratum
      https://git.kernel.org/pci/pci/c/dc4e71ddbe8e

	Krzysztof
