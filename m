Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1942D4D4A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 23:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbgLIWHk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 17:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388223AbgLIWHG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2020 17:07:06 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A367C061793
        for <linux-pci@vger.kernel.org>; Wed,  9 Dec 2020 14:06:26 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id b2so3326493edm.3
        for <linux-pci@vger.kernel.org>; Wed, 09 Dec 2020 14:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G4rcdoQ2Q+nlz9m2enoHZLfKP+zgNUV84+YxMGOGlUo=;
        b=XicTDqwD7Bb6BPkR6rAEFwXAcHWcve9QFDRj1OFlc4yRBEqoOTHfFs1h0jDGee4C6s
         6LXqXaJ3w//349o8HNlzvMTeU3u9fDWaXs3gr537fzjzxbskMMuyS4Fj/uQaubTQQQRw
         fcUkpC416XpnyFRBPYaXZs2GbQI6wAHl4vYbKnX6hCwt3k/+B2zxqA4ZTCDHnExRb/DN
         lT5mQfTQv8F9703IxGdj7LcfhBB7ytxEifj4pGjXn1m+3DzuDRRO6xNj7ECIjVQEoxRw
         8l8Wbaa6CfcfyD8WwmX1JvGza7LIdHi5Ukp6seeOqAzalqDCuZpSPQSC3HCbF6MLgsog
         ilcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4rcdoQ2Q+nlz9m2enoHZLfKP+zgNUV84+YxMGOGlUo=;
        b=t/OFNcPSsiKR2EfvfHGe9KckIRW2ekJImykqV7fGsHqMIPqvd+TXkph9gFgNbNTxf1
         r9ow12+kqkxajfG4q4vqv0ClyK1trJ3SKrqN8oZfpeAVuOsF0YkeopeBFpQvAata4sWN
         u4tx8tJKjbA0haHIkgs96DN2YspI1kRFwRnzSf6IeCgiyVfVxsqvftxJT//tplYMxsT1
         lk/vfT7KkagJ6EUf6r4W+tcy3zZnQJ4Nnj1Sr6gL+NVlAapYeWwVt3WrBk/ubSww2DrE
         ARONRwpu3r2Dl/qncBwYlBoS9IOUV3oBDWQD56r2KATZXq+eTsJyJj3tn1379hVssrTy
         twow==
X-Gm-Message-State: AOAM531F+yNLOop2qLBgzx17Zy94OOz4q1anlEbMRd5Cc6AeCXUqEtF1
        V7+fpNjT8okGSf+ChGpfw31AB2dYk63wYU5oG+Sfug==
X-Google-Smtp-Source: ABdhPJx90bhBtv+ZmxwXUbgqiVhsfzlmNC0JPYADlgNWWRJnzz8gus5K+vcmrHfPcqZOFQhFCp2k++JCBVO5ZljbgDA=
X-Received: by 2002:aa7:cdc3:: with SMTP id h3mr3933786edw.52.1607551584942;
 Wed, 09 Dec 2020 14:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20201209002418.1976362-1-ben.widawsky@intel.com> <20201209002418.1976362-11-ben.widawsky@intel.com>
In-Reply-To: <20201209002418.1976362-11-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Dec 2020 14:06:22 -0800
Message-ID: <CAPcyv4j+ixVgEo5q2OhV4kdkBZbnohZj3KDovReQJjPBsREugw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/14] cxl/mem: Add send command
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 8, 2020 at 4:24 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> The send command allows userspace to issue mailbox commands directly to
> the hardware. The driver will verify basic properties of the command but
> otherwise pass any input payload untouched to the hardware, and return
> the output payload to userspace.
>
> The caller of this IOCTL is required to allocate enough space for
> max(size_in, size_out) of the payload. The payload input data will be
> wiped out if any output payload exists.

Seems awkward for the kernel to overwrite input payloads. I can see
that potentially complicating userspace if it has the same payload to
send to multiple devices. What's the rationale for overwriting input?

>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.c            | 127 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/cxl_mem.h |  35 ++++++++++
>  2 files changed, 162 insertions(+)
>
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 2c4aadcea0e4..0bf03afc0c80 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -324,6 +324,120 @@ static int cxl_mem_count_commands(void)
>         }
>
>         return n;
> +};
> +
> +/**
> + * handle_mailbox_cmd_from_user() - Dispatch a mailbox command.
> + * @cxlmd: The CXL memory device to communicate with.
> + * @cmd: The validated command
> + * @u: The command submitted by userspace. Only useful for RAW commands.
> + *
> + * Return: 0 on success.
> + *
> + * This function packages up a &struct mbox_cmd on behalf of userspace,
> + * dispatches the command, and returns the results.
> + */
> +static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
> +                                       const struct cxl_mem_command *cmd,
> +                                       struct cxl_send_command __user *u)
> +{
> +       struct mbox_cmd mbox_cmd;
> +       ssize_t payload_size;
> +       void *payload;
> +       u32 size_out;
> +       int rc;
> +
> +       if (get_user(size_out, &u->size_out))
> +               return -EFAULT;
> +
> +       payload_size = max_t(ssize_t, cmd->info.size_in, size_out);
> +       if (payload_size) {
> +               payload =
> +                       memdup_user(u64_to_user_ptr(u->payload), payload_size);

Me thinks this should be vmemdup_user() for payloads that exceed the
kmalloc() max, and I think it would be worthwhile to clamp @size_out
to some maximum and not let userspace ask for gigantic payloads.
Return EINVAL for payloads greater than... 4MB? At least 4MB is the
arbitrary max that libnvdimm picked.

> +               if (IS_ERR(payload))
> +                       return PTR_ERR(payload);
> +       }
> +
> +       rc = cxl_mem_mbox_get(cxlmd->cxlm);
> +       if (rc)
> +               return rc;
> +
> +       mbox_cmd = (struct mbox_cmd){

I'd expect a space between: ){ ...looks like clang-format does not
have that rule.

> +               .opcode = cmd->opcode,
> +               .payload = payload,
> +               .size_in = cmd->info.size_in,
> +               .size_out = size_out,
> +       };
> +       rc = cxl_mem_mbox_send_cmd(cxlmd->cxlm, &mbox_cmd);
> +       cxl_mem_mbox_put(cxlmd->cxlm);
> +       if (rc)
> +               goto out;
> +
> +       rc = put_user(mbox_cmd.return_code, &u->retval);
> +       if (rc)
> +               goto out;
> +
> +       rc = put_user(mbox_cmd.size_out, &u->size_out);
> +       if (rc)
> +               goto out;
> +
> +       if (mbox_cmd.size_out)
> +               if (copy_to_user(u64_to_user_ptr(u->payload), payload,
> +                                mbox_cmd.size_out))
> +                       rc = -EFAULT;
> +
> +out:
> +       if (payload_size)
> +               kfree(payload);
> +       return rc;
> +}
> +
> +/**
> + * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
> + * @user_cmd: &struct cxl_send_command from userspace.

Ah cool, I did not realize kernel doc recognized type specifiers like
that, nice.

> + * @out_cmd: Sanitized and populared &struct cxl_mem_command.

s/populared/populated/

> + *
> + * Return:
> + *  * %0       - Command dispatched successfully.
> + *  * %-EFAULT - Something happened with copy_to/from_user.
> + *  * %-EINVAL - Rerserved fields were used.

s/Rerserved/Reserved/

> + *  * %-EPERM  - Protected command used by the RAW interface.
> + *  * %-ENOMEM - Input or output buffer wasn't large enough.
> + *
> + */
> +static int cxl_validate_cmd_from_user(struct cxl_send_command __user *user_cmd,
> +                                     struct cxl_mem_command *out_cmd)
> +{
> +       const struct cxl_command_info *info;
> +       struct cxl_send_command cmd;
> +       struct cxl_mem_command *c;
> +
> +       if (copy_from_user(&cmd, user_cmd, sizeof(cmd)))
> +               return -EFAULT;
> +
> +       if (cmd.id == 0 || cmd.id >= CXL_MEM_COMMAND_ID_MAX)
> +               return -EINVAL;

I wonder if the "cmd.id >= CXL_MEM_COMMAND_ID_MAX" case should return
-ENOTTY. The command might be perfectly valid, just the kernel does
not have that command specified which would be the case with older
kernel with newer userspace.

> +
> +       c = &mem_commands[cmd.id];
> +       info = &c->info;
> +
> +       if (cmd.flags & CXL_MEM_COMMAND_FLAG_MASK)
> +               return -EINVAL;
> +
> +       if (cmd.rsvd)
> +               return -EINVAL;
> +
> +       /* Check the input buffer is the expected size */
> +       if (info->size_in >= 0 && info->size_in != cmd.size_in)
> +               return -ENOMEM;
> +
> +       /* Check the output buffer is at least large enough */
> +       if (info->size_out >= 0 && cmd.size_out < info->size_out)
> +               return -ENOMEM;
> +
> +       memcpy(out_cmd, c, sizeof(*c));

Why not do the copy_from_user() directly into out_cmd to save a copy operation?

> +
> +       return 0;
>  }
>
>  static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> @@ -357,6 +471,19 @@ static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg
>
>                         j++;
>                 }
> +
> +               return 0;
> +       } else if (cmd == CXL_MEM_SEND_COMMAND) {
> +               struct cxl_send_command __user *u = (void __user *)arg;
> +               struct cxl_memdev *cxlmd = file->private_data;
> +               struct cxl_mem_command c;
> +               int rc;
> +
> +               rc = cxl_validate_cmd_from_user(u, &c);
> +               if (rc)
> +                       return rc;
> +
> +               return handle_mailbox_cmd_from_user(cxlmd, &c, u);
>         }
>
>         return -ENOTTY;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 1d1e143f98ec..189d86a13637 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -19,6 +19,7 @@ extern "C" {
>   */
>
>  #define CXL_MEM_QUERY_COMMANDS _IOR('C', 1, struct cxl_mem_query_commands)
> +#define CXL_MEM_SEND_COMMAND _IOWR('C', 2, struct cxl_send_command)
>
>  #define CXL_MEM_COMMAND_NAME_LENGTH 32
>
> @@ -48,10 +49,12 @@ extern "C" {
>  struct cxl_command_info {
>         __u32 id;
>  #define CXL_MEM_COMMAND_ID_INVALID 0
> +#define CXL_MEM_COMMAND_ID_MAX (CXL_MEM_COMMAND_ID_INVALID + 1)
>
>         __u32 flags;
>  #define CXL_MEM_COMMAND_FLAG_NONE 0
>  #define CXL_MEM_COMMAND_FLAG_TAINT BIT(0)

I guess I missed this in the last patch, why would userspace specify a
taint flag? @flags is an output parameter?

> +#define CXL_MEM_COMMAND_FLAG_MASK ~BIT(0)
>
>         __s32 size_in;
>         __s32 size_out;
> @@ -95,6 +98,38 @@ struct cxl_mem_query_commands {
>         struct cxl_command_info __user commands[]; /* out: supported commands */
>  };
>
> +/**
> + * struct cxl_send_command - Send a command to a memory device.
> + * @id: The command to send to the memory device. This must be one of the
> + *     commands returned by the query command.
> + * @flags: Flags for the command

in / out field?

> + * @rsvd: Reserved for future use.

Document 'must be zero' to match the code?

> + * @retval: Return value from the memory device (output).

Is this a translated error code or the raw
> + * @size_in: Size of the payload to provide to the device (input).
> + * @size_out: Size of the payload received from the device (input/output). This
> + *           field is filled in my userspace to let the driver know how much

s/my/by/

> + *           space was allocated for output. It is populated by the driver to
> + *           let userspace know how large the output payload actually was.
> + * @payload: Pointer to memory available for payload input/output.
> + *
> + * Mechanism for userspace to send a command to the hardware for processing. The
> + * driver will do basic validation on the command sizes, but the payload input
> + * and output are not introspected. Userspace is required to allocate large

They might be introspected, at least there were some NVDIMM ioctls
like "clear error" where the driver in addition to telling the device
to clear the error also cleaned up the kernel's error tracking list.
I'd say one of the benefits of Linux-commands that get translated to
CXL-specific payloads is that they allow for kernel translation /
interpretation / quirking vs 'raw' where the kernel does not care.

> + * enough buffers for max(size_in, size_out).
> + */
> +struct cxl_send_command {
> +       __u32 id;
> +       __u32 flags;
> +       __u32 rsvd;
> +       __u32 retval;
> +
> +       struct {
> +               __s32 size_in;
> +               __s32 size_out;
> +               __u64 payload;

per the initial comment above a separate @payload_in and a
@payload_out pointer would seem to be more flexible and get out of the
situation where the kernel needs to clobber inputs.
