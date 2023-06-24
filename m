Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B65673C9CC
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jun 2023 11:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjFXJC3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Jun 2023 05:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjFXJC2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Jun 2023 05:02:28 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488F018B;
        Sat, 24 Jun 2023 02:02:24 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-666edfc50deso1042270b3a.0;
        Sat, 24 Jun 2023 02:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687597344; x=1690189344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbHvTw8FqvH8IrxxMQFB99GCBqS/a2L3RpRPq7Xisns=;
        b=dEmllRxhbCGdKC0NfT+XjHdYVGT4cTUIj3JnAsbT4XiL9o2nsZLknch5rrvR3kMPA6
         Hs2r4uO1mpL0diqD+c4JncRVjqpIzDUyhI6WfGZPEXi05BKLd4AE6M1PyVODwtuekeNJ
         AgDDylBr2dNZ7HMQUAN6Owznsm/jJaQTSSdKw4QbfEVuNresLCy/1JPPWb0+h0HAB28e
         7Y9xwUp+l/YsD7X1sRh6zflt8OPv4Bttg39aTuOnIAHbmPs4yFb0myu/V4MXseWZ+FJY
         2Hal8e4ovulrFmG7oGsEtZCw3eW1NSPVpxXyvsO7JIr96306cehEhftMFSzuxf0i+vug
         aB/w==
X-Gm-Message-State: AC+VfDy/vKe3JfXr3ElhEQaRt0CXSYVdmbtJ5g1F03q/kIRO3yiw0OvU
        T+JfOQ0YFdLKzkvzsIdGnME=
X-Google-Smtp-Source: ACHHUZ5U7rc246WI6tuWXsBN1jnnDcmH29ARJsncYDN16vK87sDQg0Z+Zzo4lpB4Eg6BiWZUg1OxEA==
X-Received: by 2002:a05:6a00:1f11:b0:668:6ea8:7bac with SMTP id be17-20020a056a001f1100b006686ea87bacmr26020820pfb.13.1687597344313;
        Sat, 24 Jun 2023 02:02:24 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id q25-20020a62ae19000000b0064d4d11b8bfsm710335pff.59.2023.06.24.02.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 02:02:23 -0700 (PDT)
Date:   Sat, 24 Jun 2023 18:02:22 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: iproc: Use of_property_read_bool() for boolean
 properties
Message-ID: <20230624090222.GA1309310@rocinante>
References: <20230609193326.1963542-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609193326.1963542-1-robh@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to of_property_read_bool().

Applied to controller/iproc, thank you!

[1/1] PCI: iproc: Use of_property_read_bool() for boolean properties
      https://git.kernel.org/pci/pci/c/4ce7d88e7ad9

	Krzysztof
