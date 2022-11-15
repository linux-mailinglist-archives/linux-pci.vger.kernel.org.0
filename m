Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13393628FBA
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 03:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiKOCGf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 21:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiKOCGb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 21:06:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C348A18B19;
        Mon, 14 Nov 2022 18:06:30 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 129-20020a1c0287000000b003cfe48519a6so2374054wmc.0;
        Mon, 14 Nov 2022 18:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMTEO3xBaIy4RA53DCkKHIfctivoKH+czEUSAo+q9mk=;
        b=OpXETUsSO4UniSQ2OTamiym6DMzC8OKXVvxwbmI3nBE4df/uuC2Xw+RY5V+nXNFyeq
         zeMUZq3qsz84iIIjXpuwFq7GDbN0l+4LjWR2v99tdvNMxahktIle6Kfd4eNEWONGKFfk
         z+TId562nGet5JrwdQ7fpBuSpbUyyg/Yb1D6ZlhyjS6QyxNbL4X7G0rF1CI9LM3aiOv6
         AzWLCFtm7WoFuRyhnzGNmFOw6HrZwgh3qQ5HsqKPYhmHmR0vYc88RtS9/A8bCzpAq1TY
         d4Jh2O7cR6JVAyjnI17Qj5mhjV9kWWSLtV27XurCAfg0NOKlgtM6GdEpBDpHkeowLMtS
         fYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMTEO3xBaIy4RA53DCkKHIfctivoKH+czEUSAo+q9mk=;
        b=NMlh4tunfCq5T55HXarteM5T2WpYEamaaos6pJXED5Id4XA/jnxWQ/77HBHo0/c+Hm
         FnWpkb4go2JDHUC0OtYsZLBjPb0u4Kv5To9zL/Gnps7W+Ov5gpWIg7RG4I54DXotb27t
         zRhqRbOvaPuDxLtVQcBZ84dAz7YYbC2IRuwyWV1QqLmNlyh5kRVdfbtyoRX7wTVSPiLn
         t2+3Fu97WgzHdLAbKh2r66yg+7tRdQMw0q28fosA0SVDGG8KUM1uvLqjl3hdAZbGTbWQ
         cgGh7PumMkV3Y9HQEBAg4TT9jEJxhNfGFgrUvlERVALKOkFcICjl046fc1m57OEunK+v
         gJvQ==
X-Gm-Message-State: ANoB5pnuWfnzlAQIuhtYSfAO1tMnmO83VMJQWouJ7ETeWH3cw8S75NKc
        O9gDi6snxJS/giGyo8980r8E8JBVJewaDznWAxE=
X-Google-Smtp-Source: AA0mqf71B+FZ+Hn93lxrhvBrVlKn2tviKh2UWbvfZhxe5s7ATW9ew1Ou1i3FHMmCJSnr4AzoKn6sHccIaHtNP3fGsyk=
X-Received: by 2002:a1c:f219:0:b0:3cf:935a:aaab with SMTP id
 s25-20020a1cf219000000b003cf935aaaabmr9596096wmc.159.1668477989238; Mon, 14
 Nov 2022 18:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20221111142722.1172-1-longpeng2@huawei.com> <Y256ty6xGyUpkFn9@unreal>
 <0b2202bf-18d3-b288-9605-279208165080@huawei.com> <Y3Hoi4zGFY4Fz1l4@unreal>
 <d7327d46-deb5-dc75-21c3-1f351d7da108@huawei.com> <Y3I+Fs0/dXH/hnpL@unreal> <3a8efc92-eda8-9c61-50c5-5ec97e2e2342@huawei.com>
In-Reply-To: <3a8efc92-eda8-9c61-50c5-5ec97e2e2342@huawei.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 15 Nov 2022 13:06:17 +1100
Message-ID: <CAOSf1CFAG7FMjm0uzKCNMxB=0Q41JoNz7vr7mHNqEP0rr124Ug@mail.gmail.com>
Subject: Re: [RFC 0/4] pci/sriov: support VFs dynamic addition
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     Leon Romanovsky <leon@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jianjay.zhou@huawei.com, zhuangshengen@huawei.com,
        arei.gonglei@huawei.com, yechuan@huawei.com,
        huangzhichao@huawei.com, xiehong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 1:08 AM Longpeng (Mike, Cloud Infrastructure
Service Product Dept.) <longpeng2@huawei.com> wrote:
>
> *snip*
>
> Adding 2K+ VFs to the sysfs need too much time.
>
> Look at the bottomhalf of the hypervisor live update:
> kexec --> add 2K VFs --> restore VMs
>
> The downtime can be reduced if the sequence is:
> kexec --> add 100 VFs=EF=BC=88the VMs used=EF=BC=89 --> resotre VMs --> a=
dd 1.9K VFs

Right, so you want to add VFs in batches rather than all at once.
Personally I think the bitmap approach is error prone since it renders
the meaning of pf_dev->sriov->num_VFs unclear and there's some hairy
code in arch/powerpc/ that approach will likely break. A better
approach would be to add an attribute to control the number of VFs
enabled in hardware and allowing sriov_numvfs to accept any number
between the current value and sriov_hw_numvfs. e.g. your HV setup
would look something like:

echo 2048 > sriov_hw_numvfs
echo 100 > sriov_numvfs

# time passes
echo 2048 > sriov_numvfs

This would be fairly simple to implement and you can make it backwards
compatible by having writes to sriov_numvfs retain their current
semantics if sriov_hw_numvfs is zero.
