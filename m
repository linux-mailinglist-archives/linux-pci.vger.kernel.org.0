Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3876D1F0676
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jun 2020 14:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgFFMRd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Jun 2020 08:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgFFMRd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Jun 2020 08:17:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6129C03E96A;
        Sat,  6 Jun 2020 05:17:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l27so13089082ejc.1;
        Sat, 06 Jun 2020 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hk6smH/b5kGoli94Coye/vpZUm75/XTObILHR+CQub8=;
        b=TXcJ4fdZL0BsokOMUMMqykJ59VFN+WipCD2zlXZKEt5pAt7b7fQSeQHVXPxyLmK50V
         ksUybD5baLvUukSmNGKpu64CA6DbsbDV2zw8Gl1D1SMrLPkBo60IB2tKIxyRVEYj1F2x
         2SqJ+zLZaoJQIZ5uMns04hJrEyx1VBmzOXmgATDSbf44d/YmWqweOSzawiYB2hiQDGWu
         rFvycZTfM+X/WLbDBnWpCnTLPkBI43lHxLgWbF9J1mjlRQKX4KZaeLXTB6nZ6CAYcBeW
         PxmUcgn3ZfWqXLlklJuPZ5jZyX7jkyDyKw2eZ1V4L3tVjMdn0KYnDAmeNRk5HQUGo9/j
         XzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hk6smH/b5kGoli94Coye/vpZUm75/XTObILHR+CQub8=;
        b=Rvor+Os74wjz+afNL+Ao8zmVHOOEyucKsXL7EphADMesZaVBifmd1wm2Z08zLNV1vd
         l6+Oef+njaMDEh65NozINBodAZXsSW/0RpwzN74EHa40NLx28ZpiuUjwNL4uUBWhyCNm
         KI4t+JHjALblKnm30CBCA0VIah4GcO/wsS4xhzDuUkTpM8spVH//CuNz3eZibuSiavLV
         qOzqXUUQChhKsU/KgdqkQdh70NHyjbhvRdSDKv9osXd+E/LspvecSau7ge4yhvnNddEB
         U2fipuS9HZwCtNMUaHbPZbFQN6VL4AqrylrIXBQlf1aAwaAP7TMNpAMBSHzl5AALahMr
         NVOQ==
X-Gm-Message-State: AOAM530a4OifCo6GfZ2tcJtL6LylM/bwoizNkhDFtUfw43yPJ2zLhjON
        UQiPMe6kcZtDV41NQZzhajDXIEPL
X-Google-Smtp-Source: ABdhPJwSaYyoaFlbI0H8hTTfGXKsk8LoUGH+cwY4yIqCp5SSYD09Ek3aTEdXFj1HwIOtjmZwutqi9w==
X-Received: by 2002:a17:906:48d8:: with SMTP id d24mr5768698ejt.369.1591445851627;
        Sat, 06 Jun 2020 05:17:31 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id e9sm7201502edl.25.2020.06.06.05.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 05:17:30 -0700 (PDT)
Subject: Re: [PATCH] PCI: rcar: handle the failure case of pm_runtime_get_sync
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu
References: <20200605032315.39071-1-navid.emamdoost@gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <a83f5750-d58b-4a59-5253-880c74642ae2@gmail.com>
Date:   Sat, 6 Jun 2020 14:17:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605032315.39071-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/5/20 5:23 AM, Navid Emamdoost wrote:
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put if
> pm_runtime_get_sync fails.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

This looks like a V2 of
[PATCH] PCI: rcar: fix runtime pm imbalance on error

This looks good to me, but I'm no runtime-pm expert.
