Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8436C1FAE
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 19:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjCTS1Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 14:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCTS1F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 14:27:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC34E1ADCE
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 11:20:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w9so50414678edc.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679336388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yzAtbjstrZsUjwjpCw/bfjEIUoFPHmyawonL0u7Vnw=;
        b=ANETRw6VcPN8s7WEVSeoInImC6YG854DnxRHzElZcb2lgYa+1x/0GtrJSycpnMLEsq
         I1G05dTfuaFibZZ6PLiicxYrBEQ8+t6MdhDdgRmdpWgeK0XyalhSw7iXjR1mLE/w0oRy
         MZyQ55cf/hxlrg8z8KNX/IHMqbCjMxRSrwqHgOyyQm0WLYhGpi5pc1t/Up2HaQTVGX2+
         1E0jotyqpAoJCVWmhTaxZZNSkDJXwTBJLd95jnqalu3s6P6QwfLqBAFqDAr+ShX9K1p5
         Li/5qhxgiLa75Sz/bYhWt6/Mg7giiYdktzdUYBBs6SEGcu/IJX6/NeKgAjoQPUwKl7Ag
         x2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yzAtbjstrZsUjwjpCw/bfjEIUoFPHmyawonL0u7Vnw=;
        b=OkO3XT1Y+X622Zu0Fhgw4+mCGEfk1iERhkiO+WXXdqRywdJsmccrN7/sbP/t9hFrCp
         ZQvqIUI/HtCOudpkIMc9Ne9ixl2+ccZ4Y0dYb0dj/CyhesKJ4mViZSAG0xP7oopxgAZ1
         E2kJe0cMqw2TGWGpRVsvzCrycAh8hrBcJZ6KN/uEI/SDiacRgWMJ0U/kQ/jwN79ST0Xo
         os1LK2cFNAxyvOS938pL9Lw0n4RNual6beSQ9ZapJsPEON2Y8iVyJKbI/moB8KVu+rZk
         CCAENiJtdgTDi8xb6wXCc8ZAKD1V5buqw7Ekd8ptrWf56AHim5hoKBlI71RJnPV5nhar
         hiiA==
X-Gm-Message-State: AO0yUKWRCwCe1Ob1cCwDh0C4fM50eGO2GNoR+zTISEAvVxfTE7wywzmr
        BZ2UJct4DcxQRr9in4d0n2gyZw==
X-Google-Smtp-Source: AK7set9xAfo43i63Uq0DS6R9gBuA0Ce77YCStFPMj2hTG6DUCRrm5bRlcvH59L6TzpbWGMa4pcLOJQ==
X-Received: by 2002:a17:906:2b0a:b0:92f:efdc:610e with SMTP id a10-20020a1709062b0a00b0092fefdc610emr9657574ejg.66.1679336388438;
        Mon, 20 Mar 2023 11:19:48 -0700 (PDT)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090630c400b0092b5384d6desm4722243ejb.153.2023.03.20.11.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 11:19:48 -0700 (PDT)
Date:   Mon, 20 Mar 2023 18:19:50 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     eric.auger@redhat.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux.dev, Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] ACPI: VIOT: Initialize the correct IOMMU fwspec
Message-ID: <20230320181950.GA168730@myrica>
References: <20230314164416.2219829-1-jean-philippe@linaro.org>
 <CAJZ5v0jS_YAR8kwEVsi4XZ6Qd2Y1O2nMjaUSaj=NXLPMgw2O0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jS_YAR8kwEVsi4XZ6Qd2Y1O2nMjaUSaj=NXLPMgw2O0g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 20, 2023 at 06:41:09PM +0100, Rafael J. Wysocki wrote:
> This should have been posted with a CC to linux-pci really (now added).
> 
> I would recommend resending afresh with linux-pci in the CC list, so
> that the people on it don't miss this.

Sure, I resent it with the PCI list
https://lore.kernel.org/linux-pci/20230320180528.281755-1-jean-philippe@linaro.org/

Thanks,
Jean
