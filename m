Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF5BEEB712
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 19:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfJaSgC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Oct 2019 14:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbfJaSgB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Oct 2019 14:36:01 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 014A021906;
        Thu, 31 Oct 2019 18:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572546961;
        bh=+GGvRJQDbSECjkJorvzm1EDXq/8N+0xaa3y4BFOmR84=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DJgoTfOWutCHY+BK7DpMbXu0zgkmPAGOEQ50jcksR2SZp/LK0PBP57EW9+ZuP8p/b
         hi3viyM1d60/UHdam+qxXkqhetfFvaeKRbL7vO7ue8cP8uD9AR0WbRwjeB/TI1SRUC
         eS9QX3zbPO3U1Dyg6vGDpDIkxDfwmXM9ohXwpGWo=
Received: by mail-qk1-f170.google.com with SMTP id 205so6736488qkk.1;
        Thu, 31 Oct 2019 11:36:00 -0700 (PDT)
X-Gm-Message-State: APjAAAWaP1FGRZKtOPDZRVtBLSCL9q+V5rAvgr5+y7cGp+yDXNPab9qb
        fjrIXD/gQYvDPqZZCAzwSv0KIqmWxLovsMR91Q==
X-Google-Smtp-Source: APXvYqwFhgHT1SMXl79Xzh/JwuzRY9uTKEqBRGw/ukoS3FcMI33qXLJFkSMSVcxVqiKW9GQY49Vk46zwzi8XNcVs2Io=
X-Received: by 2002:a37:f703:: with SMTP id q3mr6799002qkj.254.1572546960078;
 Thu, 31 Oct 2019 11:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <710257e49c4b3d07fa98b3e5a829b807f74b54d7.1571638827.git.eswara.kota@linux.intel.com>
 <20191025165352.GA30602@bogus> <72d46086-0918-a5af-d798-7488b55a8e07@linux.intel.com>
 <24f17c73-6e90-ae7e-72a7-5223f0f5b5fd@linux.intel.com>
In-Reply-To: <24f17c73-6e90-ae7e-72a7-5223f0f5b5fd@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 31 Oct 2019 13:35:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKhCY-z+1qzLeZrfYQf0GWe6H9s4PHLa_L_qSiQheBmCA@mail.gmail.com>
Message-ID: <CAL_JsqKhCY-z+1qzLeZrfYQf0GWe6H9s4PHLa_L_qSiQheBmCA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        PCI <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 31, 2019 at 5:51 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>
>
> On 10/29/2019 4:34 PM, Dilip Kota wrote:
> >
> > On 10/26/2019 12:53 AM, Rob Herring wrote:
> >> On Mon, Oct 21, 2019 at 02:39:18PM +0800, Dilip Kota wrote:
> >>> Add YAML shcemas for PCIe RC controller on Intel Gateway SoCs
> >>> which is Synopsys DesignWare based PCIe core.
> >>>
> [...]
> >>>
> >>
> >> +
> >> +  linux,pci-domain:
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    description: PCI domain ID.
> >> Just a value of 'true' is fine here.
> > Ok.
> dt_binding_check is failing for adding 'true' alone.
> It is passing only if "$ref" is mentioned.

Update dtschema. That should be fixed.

Rob
