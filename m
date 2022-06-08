Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806F3543F12
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 00:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbiFHWWR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 18:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiFHWWQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 18:22:16 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE4E5F64
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 15:22:15 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id e67-20020a9d01c9000000b0060c221b1420so606316ote.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Jun 2022 15:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=yMd7Hozsat/nVbPGsAk4XlEU/f2AJQfxXiHNmo0Z5Nk=;
        b=NEw2wfLkuGo5EdYbuTEj6NoH4fIGrXjfeg3eNR+v7cAGl3dpHTQRSmBY3kY5BT+H1L
         LB+i8vMnE9BzZShTbzuVVLb2TuS0HtHRMEglkBIb3W/Usm7JHA06Yp6eYcZjEnNkfyjb
         tnaC988GjPJLeCcb3/ZCZidFIReqds3iFEJf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=yMd7Hozsat/nVbPGsAk4XlEU/f2AJQfxXiHNmo0Z5Nk=;
        b=ViJaXNJ9EdkmuWIJJM9fzTAj1kLIuEfFqrmGpTgWlT7CYsd96UpHy4s5RILktHSMyZ
         Or2IFoIYDbKShR1KEFnmkrqzYv2XXWY3GFLQzUfPYHZD10Zzy2172PxXFSXE7iNJncKq
         Njnx9tVq4MuDnyjlViRAOVoxmiRP5/0tmtggyg4lPr1IFZI/eXXSuyIKCQQhor8XsKT0
         2DhMgeQFW6jF/Y5/Ozx9MtgVENFk+TUyEGQzTP4Xe1ZhPVFumLFmnrmXj0AW5FqmNfGB
         aNe+rgIS2FgLYe8kmsZjNUGwMcBA4Rkn9JSqL7UlcYj9e7iPOS/Lje2xoaXwnHMz3Rfn
         9Clg==
X-Gm-Message-State: AOAM532I1XB4hvAU7l23pega2j9YV4C1aCv9nkV6j3+/dVtc7hEY+J7U
        Xusli8VPHh4A+IA/BU/RMhrmcbHNqxbtty2Smk6RXA==
X-Google-Smtp-Source: ABdhPJzATqVCjyRJ2OPemoBy04LjeGoyFitsb41S+IfCDnV1z1uSVPhS+dYzhFlqA1fCOG/KPL3VK9GV++nsKx9AStE=
X-Received: by 2002:a05:6830:113:b0:60b:eb0b:4054 with SMTP id
 i19-20020a056830011300b0060beb0b4054mr9954644otp.159.1654726934393; Wed, 08
 Jun 2022 15:22:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jun 2022 15:22:13 -0700
MIME-Version: 1.0
In-Reply-To: <1654242861-15695-1-git-send-email-quic_krichai@quicinc.com>
References: <1646679549-12494-1-git-send-email-quic_pmaliset@quicinc.com> <1654242861-15695-1-git-send-email-quic_krichai@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 8 Jun 2022 15:22:13 -0700
Message-ID: <CAE-0n527WJxDGxJ=1Y9a15+3kQvfnWSq+V0ddS3uri_i+epxQg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI/ASPM: Update LTR threshold based upon reported max latencies
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Krishna chaitanya chundru (2022-06-03 00:54:19)
> From: Prasad Malisetty <quic_pmaliset@quicinc.com>
>
> In ASPM driver, LTR threshold scale and value are updated based on
> tcommon_mode and t_poweron values. In kioxia NVMe L1.2 is failing due to
> LTR threshold scale and value are greater values than max snoop/non-snoop
> value.
>
> Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
> reported snoop/no-snoop values is greather than or equal to
> LTR_L1.2_THRESHOLD value.
>
> Signed-off-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>
> I am taking this patch forward as prasad is no more working with our org.

Not sure why it's a reply to the previous rounds. I didn't notice this
patch for a bit. Can you stop sending as replies to the previous round?

> changes since v3:
>         - Changed the logic to include this condition "snoop/nosnoop
>           latencies are not equal to zero and lower than LTR_L1.2_THRESHOLD"
> Changes since v2:
>         - Replaced LTRME logic with max snoop/no-snoop latencies check.
> Changes since v1:
>         - Added missing variable declaration in v1 patch
> ---
>  drivers/pci/pcie/aspm.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b742..c8f6253 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -461,14 +461,36 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  {
>         struct pci_dev *child = link->downstream, *parent = link->pdev;
>         u32 val1, val2, scale1, scale2;
> +       u32 max_val, max_scale, max_snp_scale, max_snp_val, max_nsnp_scale, max_nsnp_val;
>         u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
>         u32 ctl1 = 0, ctl2 = 0;
>         u32 pctl1, pctl2, cctl1, cctl2;
>         u32 pl1_2_enables, cl1_2_enables;
> +       u16 ltr;
> +       u16 max_snoop_lat, max_nosnoop_lat;
>
>         if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
>                 return;
>
> +       ltr = pci_find_ext_capability(child, PCI_EXT_CAP_ID_LTR);
> +       if (!ltr)
> +               return;
> +
> +       pci_read_config_word(child, ltr + PCI_LTR_MAX_SNOOP_LAT, &max_snoop_lat);
> +       pci_read_config_word(child, ltr + PCI_LTR_MAX_NOSNOOP_LAT, &max_nosnoop_lat);
> +
> +       max_snp_scale = (max_snoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
> +       max_snp_val = (max_snoop_lat & PCI_LTR_VALUE_MASK);

Remove useless parenthesis please.

> +
> +       max_nsnp_scale = (max_nosnoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
> +       max_nsnp_val = (max_nosnoop_lat & PCI_LTR_VALUE_MASK)

Remove useless parenthesis please.

> +
> +       /* choose the greater max scale value between snoop and no snoop value*/
> +       max_scale = (max_snp_scale > max_nsnp_scale) ? max_snp_scale: max_nsnp_scale;

Use max()?

> +
> +       /* choose the greater max value between snoop and no snoop scales */
> +       max_val = (max_snp_val > max_nsnp_val) ? max_snp_val: max_nsnp_val;

Use max()?

> +
>         /* Choose the greater of the two Port Common_Mode_Restore_Times */
>         val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
>         val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> @@ -501,6 +523,16 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>          */
>         l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
>         encode_l12_threshold(l1_2_threshold, &scale, &value);
> +
> +       /*
> +        * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
> +        * snoop/no-snoop values are greather than or equal to LTR_L1.2_THRESHOLD value.
> +        */
> +       if (scale > max_scale)
> +               scale = max_scale;

Use min()?

> +       if (value > max_val)
> +               value = max_val;

Use min()?

> +
>         ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
>
>         /* Some broken devices only support dword access to L1 SS */
