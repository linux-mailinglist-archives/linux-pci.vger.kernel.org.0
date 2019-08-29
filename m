Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 291CFA2AAB
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2019 01:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfH2X2U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 19:28:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34864 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfH2X2Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 19:28:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id gn20so2355643plb.2
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2019 16:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UELrewFF8NN0iH92okVL2LENf/NFX05X05hyTPWg0IU=;
        b=k120kgxKbzdzvv8c0Tgeo+3CuDk8ZtJzhLlATwlcEqhC/5C5t+wUkeQnzhND/1Nmd1
         6M78GmbDAJsrtaQhm6jNUjG7jee+RtBK7aetuQvupAYvXWRgoUlo+d7h6BzzrBTKefC2
         1eXKS2n4azk4TMQm7MaIHIZVAVeQ21qmyL5DRY8DeuR8mRwKI4BGf8YT91scLV/mbCY0
         /ZJUIuwC0lBbgdG1UZZI1l9/3QCMYOCLAhfCC3nZh/db85OEpcnhUEmoU/SK2N/LNq9U
         e6kLGvZwbGxQZRHIf6uFAmkxLtXO5BpDKlq7OyeRIdkn7p8hEn4iYohyh7yXDD/CPAWh
         ytZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UELrewFF8NN0iH92okVL2LENf/NFX05X05hyTPWg0IU=;
        b=T/OSYdzZByW2wfO+fo8B131cZd9NLU56qVCVLvTulSdjt1BevrsI06GFz9TTMSDGSq
         0A+006YTRo+Jg6+hoXmnKcSIWl8J/tuYMfBa6NATw0xJSQH/bZa2CBuNOD/evUm7auaj
         7scW18iuQVKolrwiDn1TfhFOiYh2Yto0lhEjgn15P/M7V78JrOR++FWaBxrbfP1ZXv4S
         g97h/lZfcxarxbxZTnBnAAdMbHhR7l3nS4cKAhExJKJ8xgc7BCAIBI9uRqZ+h6nLWmx2
         PdayR1fMNv2E8p6zKh32WwDQsa79ZA03fKF8kG8hP2LjjLaYzJQvA/HSdDK5S22btw+D
         foxg==
X-Gm-Message-State: APjAAAXdWPw3tRO5hyRpAyuEBBEJJ1dcFJ45Ek80QDNgbqRGNnJKyoUT
        3au3kYtJeMMlDwjZSwBg3dVYKlDaD6m9fyyZQbsHDg==
X-Google-Smtp-Source: APXvYqxF8GTTIW5esjRxN2qu78uhNM5IBHoP85JOWcDzALTrrZV1TDADOXjuJ1weL4cTxfZFBAARSF+74BWd4bhJA9w=
X-Received: by 2002:a17:902:96a:: with SMTP id 97mr12618288plm.264.1567121295532;
 Thu, 29 Aug 2019 16:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190827062309.GA30987@kroah.com> <20190827222145.32642-1-rajatja@google.com>
In-Reply-To: <20190827222145.32642-1-rajatja@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 29 Aug 2019 16:27:39 -0700
Message-ID: <CACK8Z6EAqVb20rXHut8mqTaeO1R6uH_zLxi=3wVPgYycDuuPSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI/AER: Add PoisonTLPBlocked to Uncorrectable errors
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 27, 2019 at 3:21 PM Rajat Jain <rajatja@google.com> wrote:
>
> The elements in the aer_uncorrectable_error_string[] refer to
> the bit names in Uncorrectable Error status Register in the PCIe spec
> (Sec 7.8.4.2 in PCIe 4.0)
>
> Add the last error bit in the strings array that was missing.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v3: same as v2
> v2: same as v1

Hi Bjorn,

This patch seems like independent of the other patch to split the AER
stats. Can you review and apply this one so that I don't have to keep
sending v4, v5 (where each version is basically same as v1) ... of
this patch with every iteration of the other patch?

I'll be working on Greg's and your comments on the other patch.

Thanks,

Rajat


>
>  drivers/pci/pcie/aer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index b45bc47d04fe..68060a290291 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -36,7 +36,7 @@
>  #define AER_ERROR_SOURCES_MAX          128
>
>  #define AER_MAX_TYPEOF_COR_ERRS                16      /* as per PCI_ERR_COR_STATUS */
> -#define AER_MAX_TYPEOF_UNCOR_ERRS      26      /* as per PCI_ERR_UNCOR_STATUS*/
> +#define AER_MAX_TYPEOF_UNCOR_ERRS      27      /* as per PCI_ERR_UNCOR_STATUS*/
>
>  struct aer_err_source {
>         unsigned int status;
> @@ -560,6 +560,7 @@ static const char *aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCOR_ERRS] = {
>         "BlockedTLP",                   /* Bit Position 23      */
>         "AtomicOpBlocked",              /* Bit Position 24      */
>         "TLPBlockedErr",                /* Bit Position 25      */
> +       "PoisonTLPBlocked",             /* Bit Position 26      */
>  };
>
>  static const char *aer_agent_string[] = {
> --
> 2.23.0.187.g17f5b7556c-goog
>
