Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB2F57CA94
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 14:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiGUMYG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 08:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGUMYF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 08:24:05 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E71F21E1E;
        Thu, 21 Jul 2022 05:24:04 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10d6e8990b9so2129146fac.7;
        Thu, 21 Jul 2022 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImwLpat+1sPYdOj7Iczdt+M/YFfAZGN24qOSHSTu1vc=;
        b=fsnOG1id6H4i0ySXm6YWreNVF7KeIpTVioFDQOlXK3RiVgjb73e8Qa+QS9EGxb8ZeO
         V1tm2lFPzYrFUBhZhKtUjijRYcdDEQQ/SviFPC4g1+EMei9t/bSL9Dh5vWVp3HW5r6Af
         RQRUJhOBqNBN7n30ANShNkCd71QY+75ZSvSWlDOJKaj6IxVG5LyxI8zOFLC3khAfECQn
         AhM3c+GzSVJh4+fI+/qXknh6qwE059yMnFjLuJ/oVcQPBlpStZdilSnboCDNCRlclvaN
         lu6esVq/IN6Lckd2Co1AfFTJFknofaVhpla/PWbPZuigM44UYuIixtGQzLxk7CeXBCKs
         g8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImwLpat+1sPYdOj7Iczdt+M/YFfAZGN24qOSHSTu1vc=;
        b=vF449iFt8JuQttLdBUf8AsUtwzV5YIHDPs/vBql5LJHL1mDzTki6MYjCBWDH/CiBH6
         1AWZ0UI1J8j4gJpCqkIvVB8xi9MYSsschdSsWVu1+9owegPmffQv5BjOFe5/lePMLUT+
         yGI2HBSvC3Fj1bDy5au1GSHSxgZPKUTwBQDwMLFviptEYW53S8RrSlPo5Ybac/wxNTAz
         1BZ8nTTgrhPIgDbu86g35sd9m+45Q82khHRwE88/K8hoYxFlxZErxYLlose3cG7z4LtS
         etEjqo2g5ygEfAX/VyJSDy8LXvbt9hPLJW+V78IdN8fC2GA3j23aczx6WeH9OvW7okkQ
         OPgg==
X-Gm-Message-State: AJIora+qevTYx/TYAdC5/xUJwctb6d9yqpDe13kumXZMo4jwD7t/Pb8j
        7S6ZAjqIlY5GORIn/1CmQssok39qw8IpJARnvuY=
X-Google-Smtp-Source: AGRyM1tEjr8y+gdoyIFOFwb1TodPOJkj9G4SjX5rY0CJ6zGtLqwRg8jjmzwVI7hfd/F8AgDcMrepZDGjx9iSpjrDcXM=
X-Received: by 2002:a05:6870:2111:b0:e9:768:f288 with SMTP id
 f17-20020a056870211100b000e90768f288mr4980852oae.45.1658406243729; Thu, 21
 Jul 2022 05:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHP4M8VuX6NrqyKQU1KS3DdTzZRQTdPK+nF0-eXXeQqhHyOypw@mail.gmail.com>
 <20220713181805.GA841376@bhelgaas> <CAHP4M8X67WSLMqe2qQrbODrg5oSLvR5fP4JVN+zeQafHizrOXA@mail.gmail.com>
 <ff345fdf-4398-0275-1e1d-f87e15b31d3a@ti.com>
In-Reply-To: <ff345fdf-4398-0275-1e1d-f87e15b31d3a@ti.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Thu, 21 Jul 2022 17:53:50 +0530
Message-ID: <CAHP4M8WfngsoAAA=7CUeqEf2SME+4HvZ+9zAe-0pxOLmS62bAw@mail.gmail.com>
Subject: Re: No controller seen in /sys/kernel/config/pci_ep/controllers
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thank you, that helps.

> Not sure what exactly your use case is.

Nothing complicated, I was stuck on the first step of having the
pci-controller in endpoint-mode :)
Your reply has given me a direction : I will try and find a
hardware/setup wherein I can have a pci-controller in endpoint-mode.


Thanks and Regards,
Ajay
