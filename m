Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBDE2542B6
	for <lists+linux-pci@lfdr.de>; Thu, 27 Aug 2020 11:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0JtY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Aug 2020 05:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0JtY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Aug 2020 05:49:24 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF08C061264;
        Thu, 27 Aug 2020 02:49:24 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id w10so3915221oti.2;
        Thu, 27 Aug 2020 02:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RuGAUjmXUBGiB092kZEexqQx1sR3+FlOyRMdRS1FNSo=;
        b=XwGLd+WjrhAl+9Svu7UFMHGyS1zmiL97JSPPCgXMOjttWQ5iefrU8fyu5Sxn39R9ql
         hbgdlmCqndUKDKCZfzsQKg1xzTQFENsNmzYhNmHfqti+l8joJ9FEK0ckeFyKqKLMaMTp
         jDJDVn/eM3UPUcCN1hN+sb9VrhAsVTVC8q5SDjotuvsIMEXSgga33jph+PDUjkGPgxih
         f/RsVDHKI7aS8EtaEs6iZtlpjPDYSYgwLXHrCqwCkgDwfyBmioCqkmiOVufVOS6MVRGl
         Piz9dIs9bjs1YOe+5aYVIafY7CEC8uToBgtmXd0qG+FgKflsbCGd6wRIjbOfEEUOW+Fk
         i+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RuGAUjmXUBGiB092kZEexqQx1sR3+FlOyRMdRS1FNSo=;
        b=fycuV4SxIoz2Bo8NJInpd5r5XBNE9R5eHePe7Vx5fFUEuFMPs0Zw3Kh2WJPQSVewXY
         REKEBrn53D2mj+aXPfIQE3JCP1x1qk0c+SIS8eAlwWSWMpap5LlY1fH2NAug/lkTOLH0
         doetL5GWbdImCIPszkyPail+rEi1j5wYZkMXhT5aZUttCv19O2ydKXiRHRJbh+VGn5vr
         8xMNns1JpKK8tvTPGnkvev8mJboikbcUDRGuwwxplB+VQOt5kIoNdfYUp6goh6dxhOn+
         ct01BWhASv9h5FSrbuuJNndbZGnBDay+CTtxlS7C3H1lzU7vbo8KLQPUwvFLhWtLB3uO
         pbMA==
X-Gm-Message-State: AOAM530Cnv0lqhKvdThyQGB/YVlAoHlLxUNC8btAXA82FXzdDJrumpFy
        OGcCciPWWonHQ7U9VaMxfUCyiLm+yGLnToT6RR2jhiIcblM=
X-Google-Smtp-Source: ABdhPJzBXpF2iMhfDU7FNuj/HS+EcADfmCCx4lF6DzLNmG5sT1kXcFTbnZJhJXqcWeM4ClYU21InYlAhbhB+pYbLk0U=
X-Received: by 2002:a9d:7e85:: with SMTP id m5mr795514otp.330.1598521763351;
 Thu, 27 Aug 2020 02:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200824052025.48362-1-benbjiang@tencent.com>
In-Reply-To: <20200824052025.48362-1-benbjiang@tencent.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Thu, 27 Aug 2020 17:49:12 +0800
Message-ID: <CAPJCdBmLeD84kRXWmuPj+-_2kBLmZ8wR-uJ641xShza6E52D0w@mail.gmail.com>
Subject: Re: [PATCH] driver/pci: reduce the single block time in pci_read_config
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>,
        Bin Lai <robinlai@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

kindly ping :)

On Mon, 24 Aug 2020 at 13:20, Jiang Biao <benbjiang@gmail.com> wrote:
>
> From: Jiang Biao <benbjiang@tencent.com>
>
> pci_read_config() could block several ms in kernel space, mainly
> caused by the while loop to call pci_user_read_config_dword().
> Singel pci_user_read_config_dword() loop could consume 130us+,
>               |    pci_user_read_config_dword() {
>               |      _raw_spin_lock_irq() {
> ! 136.698 us  |        native_queued_spin_lock_slowpath();
> ! 137.582 us  |      }
>               |      pci_read() {
>               |        raw_pci_read() {
>               |          pci_conf1_read() {
>   0.230 us    |            _raw_spin_lock_irqsave();
>   0.035 us    |            _raw_spin_unlock_irqrestore();
>   8.476 us    |          }
>   8.790 us    |        }
>   9.091 us    |      }
> ! 147.263 us  |    }
> and dozens of the loop could consume ms+.
>
> If we execute some lspci commands concurrently, ms+ scheduling
> latency could be detected.
>
> Add scheduling chance in the loop to improve the latency.
>
> Reported-by: Bin Lai <robinlai@tencent.com>
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> ---
>  drivers/pci/pci-sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6d78df9..3b9f63d 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -708,6 +708,7 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
>                 data[off - init_off + 3] = (val >> 24) & 0xff;
>                 off += 4;
>                 size -= 4;
> +               cond_resched();
>         }
>
>         if (size >= 2) {
> --
> 1.8.3.1
>
