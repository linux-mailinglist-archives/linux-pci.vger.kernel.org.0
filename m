Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043675B548F
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 08:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiILGdm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 02:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiILGdk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 02:33:40 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8293140DE;
        Sun, 11 Sep 2022 23:33:39 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id s18so2501890qtx.6;
        Sun, 11 Sep 2022 23:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=cI+bqxN709u5iH247nsXFi4kCp0HAzKLiY9JaIh7EwE=;
        b=XFJziblgFP9ag+yT5LaaQoOoRauZfid9V02iiCCP1Z1HXV/hJchI3KiiTdpBmdAYFs
         84KNG3dT/WbTOU1ELHvVT3uy5/GDKb2JZOxmwP5OyABjSQJPKWk/6sb/F11eslPcoux/
         TU7YNA/sZ2lyxXNDQljUD9E3z+RQd+Y6Jdbux6+hMyuwH5tBUvX4DsEKjsBEoGlQqTfc
         lRFhwA6mQbmIygg+XGXkTIw0MbT10F2bginK47zdNNLdb/G+77FGVtkvCYjIRoIRS0Db
         6J2b7pOzpIgEsHMQThpvLGY9ARkljfWV0VtiREsX9YMA7MhOJn+iZobAj3piQnrSUr2Q
         I+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cI+bqxN709u5iH247nsXFi4kCp0HAzKLiY9JaIh7EwE=;
        b=P7W/+4ICkpdYuqKfgazsCrgYE4MOlNL66A2jUj6+WnpUSgyDktCyubkzfxz9N+6HkM
         IZ8scFqiOwYG1hvumpuUGaiR8AUd8UOqoKtJc8G98s4bLnALGefrMrdRiSthVMSMuvUG
         /Cg45Ljge7JcmCbHJmTdAkXvTRPlxEEO/oTvL6+FGlYnCM1TyZtFmI6G2YiytPQirTXl
         io7W5GMHLXmNlDXoLk0nkqpyASFd0hniXAiLM7cGU8fWWDdVXYv4dn0zp34R28poWCfj
         zwWy1LkH38jmfVGFah36/C4+jzQUWtElJrVEVxYg8YSXU4dL0hv+TymjGB0HpL23m7/w
         qH2A==
X-Gm-Message-State: ACgBeo38d6HAA7L3JMoMHtuZ5NCl9E7aSGvNs/0g3opWSuWLjZcqSe9E
        ZrltniQw4QEPrMXdM2qNY5w=
X-Google-Smtp-Source: AA6agR7/npuTbZ9cV5g+Eo7cBhK3JDzHlWCq7eoiI71+djkPW2FOxIQnwLg0pIF+y/bdQxtfR5TYvw==
X-Received: by 2002:ac8:690b:0:b0:343:5bc0:78a0 with SMTP id bt11-20020ac8690b000000b003435bc078a0mr21579547qtb.535.1662964418979;
        Sun, 11 Sep 2022 23:33:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:b5d7:d916:de6d:55a0? ([2600:1700:2442:6db0:b5d7:d916:de6d:55a0])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a244300b006cbb8ca04f8sm3242893qkn.40.2022.09.11.23.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 23:33:38 -0700 (PDT)
Message-ID: <dd823b9c-fe7f-7c47-520c-bad5a798efc2@gmail.com>
Date:   Mon, 12 Sep 2022 01:33:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC 2/2] pci: create device tree node for selected devices
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, helgaas@kernel.org,
        clement.leger@bootlin.com, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <1661809417-11370-3-git-send-email-lizhi.hou@amd.com>
 <20220902185403.GA173255-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220902185403.GA173255-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/2/22 13:54, Rob Herring wrote:
> On Mon, Aug 29, 2022 at 02:43:37PM -0700, Lizhi Hou wrote:
>> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
>> spaces from multiple hardware peripherals to its PCI BAR. Normally,
>> the PCI core discovers devices and BARs using the PCI enumeration process.
>> And the process does not provide a way to discover the hardware peripherals
>> been mapped to PCI BARs.

< snip >

> 
> The above bits aren't really particular to PCI, so they probably 
> belong in the DT core code. Frank will probably have thoughts on what 
> this should look like.

< snip >

I will try to look through this patch series later today (Monday 9/12
USA time - I will not be in Dublin for the conferences this week.)

-Frank
