Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6086CD5AA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 10:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjC2I5u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 04:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjC2I5f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 04:57:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B9E5FE1;
        Wed, 29 Mar 2023 01:56:29 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s8so9803644pfk.5;
        Wed, 29 Mar 2023 01:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680080162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySutP184d82W7fN6mvGhEjSC5Ip3/jQvH7++xHWlWiw=;
        b=J7DjtOYfKXM4C4pas0CZ3b2I1pbAGI3010Z8w0e8sl/ILRhCGPLadaaB/FnVw4sKu5
         nquBDjvt0VlOSsOy94iWgshXgZ6NN5f0Oci8GTzSjf+ZqMTNSnqvAvCp2N/bRdmFmfRj
         cC07+fWtNMgwkJbjrjzMEOZ1QzX8YbWjrD/ofwA6xEKzqTUQ/fW2+TauW0ywZOSjG6tp
         yvRGzrsuRwvHeyYFViHqegAhpUfahFKdMt+STtBfbNEr925Cs0ANqJ+GRxTA9lNI6rH4
         pAVXuuYOsJ/d3NyeaFRVJupWFWn7wEe/gsXa1ReX47MZxv7wWYxRIDD4ZCuXEFMR8o9r
         Q4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySutP184d82W7fN6mvGhEjSC5Ip3/jQvH7++xHWlWiw=;
        b=ZtuPZuxnLrsur7XHtAWy9bz3ejRlVhU5Zvf4LH4bKDGZvVFyduRlyMl5Au6v5ME8FE
         8olnjqCs+Qbud/3pFojKyYzwOPX7Vo0vDkF7HcPgbh1LXMAXraOnUNDbQPv9xEXuTTj7
         nl+wMgN3aej6LVAavgtFzoJpibkavDF2b0mAs2uwaX7P5tE5JmN05jCZzDqMOMetkMWj
         MIE0L69hcj+td4UJJVpvhrCqO13vN1yYKcwvkYtHA2L+9w7vslqxdr3dOFvwAMeAtnLP
         zERhR26lgY0r/TKJPkhmGAQpPVsPj/wbIKomtJpkLIYZYWvG6m1ISbAglpoI6CjlZXu6
         w1gA==
X-Gm-Message-State: AAQBX9dTcoikUyLAxx4j6XrkSLgONV9PRIiCv6xSd2zaY9tn0ueDTuXP
        XZ/hC6ElIG6KP4OzEOXClX6wwkUbvfKiuYj2mek=
X-Google-Smtp-Source: AKy350bIhDz0t9FDg+MSQ8x/lt/7WH/rvZ2R1xnHzZJ9OwsE5egrUPLiQev3HHOQNhatEHtm5F88rgpgGkU4CpBYEAk=
X-Received: by 2002:a05:6a00:b93:b0:62b:e52e:1bb with SMTP id
 g19-20020a056a000b9300b0062be52e01bbmr8538792pfj.0.1680080162312; Wed, 29 Mar
 2023 01:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230320132316.3126838-1-korantwork@gmail.com> <20230328213437.GA2963709@bhelgaas>
In-Reply-To: <20230328213437.GA2963709@bhelgaas>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Wed, 29 Mar 2023 16:57:08 +0800
Message-ID: <CAEm4hYW3zvte_kdWMFrv-pKVijQaL7KzbE12WHuO14s73ExUbQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: vmd: Add the module param to adjust MSI mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 29, 2023 at 5:34=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> "two params: on, off ... default param is NULL" doesn't read quite
> right because "NULL" is not a valid parameter value.
>
> I think you could just omit that last sentence completely because it's
> obvious that if you don't specify the parameter, it doesn't affect
> anything and the existing behavior is unchanged (it's determined by
> whether VMD_FEAT_CAN_BYPASS_MSI_REMAP is specified in vmd_ids[]).
>
Your opinion is more reasonable. I will omit this sentence.
>
> > Signed-off-by: Xinghui Li <korantli@tencent.com>
> > Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>
> I think Lorenzo is out of the office this week, but I'm sure he'll
> take care of this when he returns.
>
> In the meantime, can you include a sample usage in the commit log so
> folks don't have to dig through the patch and figure out how to use
> the parameter?
>
I will add instructions on how to use this parameter.
>
> It would also be nice to include a hint about why a user would choose
> "on" or "off".  What is the performance effect?  What sort of I/O
> scenario would lead you to choose "on" vs "off"?
>
Before this patch, I sent the patch named :
PCI: vmd: Do not disable MSI-X remapping in VMD 28C0 controller
(patchwork link:
https://patchwork.kernel.org/project/linux-pci/patch/20221222072603.1175248=
-1-korantwork@gmail.com/)
We found the 4k rand read's iops could drop 50% if 4 NVMEs were
mounted in one PCIE port with VMD MSI bypass.
I suppose this is because the VMD Controller can aggregate interrupts.
But those test result is so long that I didn't add them to this patch
commit log.
If you believe it is necessary, I will try to add some simple instructions
>
> ee81ee84f873 ("PCI: vmd: Disable MSI-X remapping when possible")
> suggests that MSI-X remapping (I assume the "msi_remap=3Don" case):
>
>   - Limits the number MSI-X vectors available to child devices to the
>     number of VMD MSI-X vectors.
>
>   - Reduces interrupt handling performance because child device
>     interrupts have to go through the VMD MSI-X domain interrupt
>     handler.
>
> So I assume "msi_remap=3Doff" would remove that MSI-X vector limit and
> improve interrupt handling performance?
>
> But obviously there's more to consider because those are both good
> things and if we could do that all the time, we would.  So there must
> be cases where we *have* to remap.  ee81ee84f873 suggests that not all
> VMD devices support disabling remap.  There's also a hint that some
> virt configs require it.
>
I used to just want to disable 28C0's VMD MSI bypass by default.
But Nirmal suggested the current method by adjusting the param.
Because he and other reviewers worry there are some other scenarios we
didn't consider.
Adding a method to adjust VMD'S MSI-X mode is better.

> This patch doesn't enforce either of those things.  What happens if
> the user gets it wrong?
>
If I am wrong, please feel free to correct me at any time.
I place the "vmd_config_msi_remap_param" that is VMD MSI-X's mode
param configuring helper front
"vmd_enable_domain". So, It will not change the logic disabling
remapping from ee81ee84f873, such as
"Currently MSI remapping must be enabled in guest passthrough mode".
So, if the user config the wrong type, it will not work, and they can
find it by dmesg.
And that's why I add the MSI-X mode init print.
>
> Spurious blank line.
sorry for this
>
>
> ee81ee84f873 mentions MSI-X explicitly (which is different from MSI),
> so maybe use "MSI-X" here and in the messages below to avoid any
> confusion.
>
That's nicer.
>
> The usual strcmp() idiom is to test "!strcmp(...)" instead of
> "strcmp(...) =3D=3D 0)".  No need for "()" around
> VMD_FEAT_CAN_BYPASS_MSI_REMAP.
>
All right, I will change it to "!strcmp()" way.

Thanks for you review~
