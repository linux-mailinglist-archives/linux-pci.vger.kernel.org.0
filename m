Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1E36336BD
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 09:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiKVIMK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 03:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiKVIL7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 03:11:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9F83F07D;
        Tue, 22 Nov 2022 00:11:57 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso13039651pjt.0;
        Tue, 22 Nov 2022 00:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btLM7ioiVORnm3lEYHf5T5x/aS6QHwdNoAQEJBXdHAc=;
        b=M1jLnNubYt0SrwfSW9i33n6YX1ESpn28PZnSjooKh5wdJp0U3GRDiUEoEkEBFtfJDP
         4dkjfxA1VTmYtoudabd51wBXPWcEaawZxcMTcUZJwZ46wusGDqOZcK3qn4UjMWbLxRui
         n4byirPUyNnplpDep6IBcqP49UpD/GA09QeuUn6PeUF/6yiNOzcyo83YUX6QuvdrFEbH
         HxDGK+TPhvn4EniN8wO+Zg3s4Jc0cO82Ha/s8kAorlDgzCKxWkhUQHq8j2FB5Y9GU9mV
         Cwgjbffjc4fUeAwn6XVyKeJnwcmIO3SUzpKl4jq8MT0Fd5lWQHDSDe6nyjFt8fFXbneW
         7O+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btLM7ioiVORnm3lEYHf5T5x/aS6QHwdNoAQEJBXdHAc=;
        b=P0Br42GokGvwuo4qbpP0wlQJUzQlGxkqEcr5Df0qx87cq7mYw70ts+m5zemQ4zowSs
         QfEtpwW4TqxkY4AO9wiN/MCtNIjL5rE2YWcsalvyYEf88ZuZVGZxuWwLJiN1+SeuqJsJ
         QtXu4cF3m+/+Z6AveS5X+CmHK8Ny+ckvtTso2/cmu57EYQ7/PMO/WJf8Pq86N2CMnkzW
         +5woP0e77OQCidM4NmJc2fQKtJLaxc1hqQMkEgD9bYxdhLnkAbBL3LwvGF/RzotS61Ek
         SPU1Ltk1zrD76zVdC7DD01XAvjzzhZHutytim8QnrhtKu810xTPAYZrOuKuAmY2WWCPO
         Q1BA==
X-Gm-Message-State: ANoB5pnHMv6qhex1ozm9BB0QQMuNkYqpQk9zLXmQsictp04d9XGrvZn5
        ZaR0dg/qOjPgFsFREzTBzHE=
X-Google-Smtp-Source: AA0mqf4rUn0XDlqrmJJBd6NyKaOBpE5iWvUY5T498CL9cJwO2dSokFPls/EDnGAcTn7P77yiHWPvfg==
X-Received: by 2002:a17:902:ef44:b0:185:40ca:68b8 with SMTP id e4-20020a170902ef4400b0018540ca68b8mr4368853plx.16.1669104717383;
        Tue, 22 Nov 2022 00:11:57 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-4.three.co.id. [180.214.233.4])
        by smtp.gmail.com with ESMTPSA id e7-20020aa798c7000000b0056bee23a80bsm9994602pfm.137.2022.11.22.00.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 00:11:57 -0800 (PST)
Message-ID: <492af720-43ad-15d6-f21c-b94eea5442b5@gmail.com>
Date:   Tue, 22 Nov 2022 15:11:53 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] PCI/MSI: api: Use bullet lists in kernel-doc comments
Content-Language: en-US
To:     "Ahmed S. Darwish" <darwi@linutronix.de>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-doc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20221121184100.0974cc35@canb.auug.org.au>
 <20221121101245.23544-1-bagasdotme@gmail.com> <Y3t83uo/TZzxc1nL@lx-t490>
 <Y3xFV2IkUlRWPdCd@debian.me> <Y3xkj/3G4JxgXlal@lx-t490>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Y3xkj/3G4JxgXlal@lx-t490>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/22/22 12:56, Ahmed S. Darwish wrote:
> On Tue, Nov 22, 2022 at 10:43:19AM +0700, Bagas Sanjaya wrote:
>>
>> For the list above, no, since if the alignment is kept, like:
>>
> 
> NAK.
> 
> Below patch works properly on my side, no Sphinx errors and proper HTML
> view, while still keeping proper-alignment in the C code.
> 
> Sorry, you're too focusing on the HTML side.
> 
> Making the C code readable, not just the HTML output, is quite
> important.
> 
> =>
> 
> From: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> Use bullet-list RST syntax for kernel-doc parameters' flags and
> interrupt mode descriptions. Otherwise Sphinx produces "Unexpected
> identation" errors and warnings.
> 
> Link: https://lore.kernel.org/r/20221121101245.23544-1-bagasdotme@gmail.com
> Fixes: 5c0997dc33ac24 ("PCI/MSI: Move pci_alloc_irq_vectors() to api.c")
> Fixes: 017239c8db2093 ("PCI/MSI: Move pci_irq_vector() to api.c")
> Fixes: be37b8428b7b77 ("PCI/MSI: Move pci_irq_get_affinity() to api.c")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> [darwi@linutronix.de: Match subject-line with other subystem commits]
> [darwi@linutronix.de: Remove verbose Sphinx log from commit log]
> [darwi@linutronix.de: For C kernel-doc comments legibility, keep
>  the flags and interrupt mode descriptions aligned.]
> Acked-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
> 
>  drivers/pci/msi/api.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index dfcaa77108de..6c0c0f3ad3b8 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -209,12 +209,15 @@ EXPORT_SYMBOL(pci_disable_msix);
>   * @min_vecs: minimum required number of vectors (must be >= 1)
>   * @max_vecs: maximum desired number of vectors
>   * @flags:    One or more of:
> - *            %PCI_IRQ_MSIX      Allow trying MSI-X vector allocations
> - *            %PCI_IRQ_MSI       Allow trying MSI vector allocations
> - *            %PCI_IRQ_LEGACY    Allow trying legacy INTx interrupts, if
> - *                               and only if @min_vecs == 1
> - *            %PCI_IRQ_AFFINITY  Auto-manage IRQs affinity by spreading
> - *                               the vectors around available CPUs
> + *
> + *            * %PCI_IRQ_MSIX      Allow trying MSI-X vector allocations
> + *            * %PCI_IRQ_MSI       Allow trying MSI vector allocations
> + *
> + *            * %PCI_IRQ_LEGACY    Allow trying legacy INTx interrupts, if
> + *              and only if @min_vecs == 1
> + *
> + *            * %PCI_IRQ_AFFINITY  Auto-manage IRQs affinity by spreading
> + *              the vectors around available CPUs
>   *
>   * Allocate up to @max_vecs interrupt vectors on device. MSI-X irq
>   * vector allocation has a higher precedence over plain MSI, which has a
> @@ -299,10 +302,11 @@ EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
>   * pci_irq_vector() - Get Linux IRQ number of a device interrupt vector
>   * @dev: the PCI device to operate on
>   * @nr:  device-relative interrupt vector index (0-based); has different
> - *       meanings, depending on interrupt mode
> - *         MSI-X        the index in the MSI-X vector table
> - *         MSI          the index of the enabled MSI vectors
> - *         INTx         must be 0
> + *       meanings, depending on interrupt mode:
> + *
> + *         * MSI-X     the index in the MSI-X vector table
> + *         * MSI       the index of the enabled MSI vectors
> + *         * INTx      must be 0
>   *
>   * Return: the Linux IRQ number, or -EINVAL if @nr is out of range
>   */
> @@ -322,10 +326,11 @@ EXPORT_SYMBOL(pci_irq_vector);
>   * pci_irq_get_affinity() - Get a device interrupt vector affinity
>   * @dev: the PCI device to operate on
>   * @nr:  device-relative interrupt vector index (0-based); has different
> - *       meanings, depending on interrupt mode
> - *         MSI-X        the index in the MSI-X vector table
> - *         MSI          the index of the enabled MSI vectors
> - *         INTx         must be 0
> + *       meanings, depending on interrupt mode:
> + *
> + *         * MSI-X     the index in the MSI-X vector table
> + *         * MSI       the index of the enabled MSI vectors
> + *         * INTx      must be 0
>   *
>   * Return: MSI/MSI-X vector affinity, NULL if @nr is out of range or if
>   * the MSI(-X) vector was allocated without explicit affinity

Personally I'd like to write the entries as:

  * term - definition

But anyway, your suggestion patch LGTM. Thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

