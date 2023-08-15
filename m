Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C77D77C686
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 05:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjHODxz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 23:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjHODw0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 23:52:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9F1E7E;
        Mon, 14 Aug 2023 20:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1692071539;
        bh=WipNlHOpHfl2S9cGwbe9j74qSCdK+cUZfrf7SFk1wb4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=apekYgD9k+drgI4RI/aemoBomLvy1KqqUkRpN/1xd3wRfeaxaSin9q0NwqB8s7O/K
         rzkoXWx+x3jk0gXCD5V1Z8SgBXjxzRc8hGts/UXSJzCLkHJVGSKI3ho6jEr+M6vCTV
         P+zvFJUynb3zmjekbpy0xX+dCRWhG91zLN4Wc5M9n2PoSTbS8Zhr6OgqMz7kkigolR
         F6UT+LTcBlA4nD/nPXGIPvY4pdCUUOBF8ArZcbWLz174FBZ0EonzNPo9Lx88ySQk+T
         AFkL/FdF+Q/KVYBoibTkcQaPuHt96kOJYVANVuwLodSuySp333NY92E14p6CLxbbA3
         +C/6DeoqZiaIQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPy5H2P5Hz4wxn;
        Tue, 15 Aug 2023 13:52:19 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] powerpc/rtas: Rename rtas_error_rc to
 rtas_generic_errno
In-Reply-To: <169138864808.65607.6576358707894823512.stgit@jupiter>
References: <169138864808.65607.6576358707894823512.stgit@jupiter>
Date:   Tue, 15 Aug 2023 13:52:14 +1000
Message-ID: <877cpxdksx.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mahesh Salgaonkar <mahesh@linux.ibm.com> writes:
> rtas_generic_errno() function will convert the generic rtas return codes
> into errno.

I don't see the point of renaming it, it just creates unnecessary churn.
The existing name seems OK to me.

...

> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index 3abe15ac79db1..5572a0a2f6e18 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -202,7 +202,9 @@ typedef struct {
>  #define RTAS_USER_REGION_SIZE (64 * 1024)
>  
>  /* RTAS return status codes */
> -#define RTAS_BUSY		-2    /* RTAS Busy */
> +#define RTAS_HARDWARE_ERROR	(-1)  /* Hardware Error */
> +#define RTAS_BUSY		(-2)  /* RTAS Busy */

Are the brackets necessary?

> +#define RTAS_INVALID_PARAMETER	(-3)  /* Invalid indicator/domain/sensor etc. */
>  #define RTAS_EXTENDED_DELAY_MIN	9900
>  #define RTAS_EXTENDED_DELAY_MAX	9905
>  
> @@ -212,6 +214,11 @@ typedef struct {
>  #define RTAS_THREADS_ACTIVE     -9005 /* Multiple processor threads active */
>  #define RTAS_OUTSTANDING_COPROC -9006 /* Outstanding coprocessor operations */
>  
> +/* statuses specific to get-sensor-state */
> +#define RTAS_SLOT_UNISOLATED		(-9000)
> +#define RTAS_SLOT_NOT_UNISOLATED	(-9001)
> +#define RTAS_SLOT_NOT_USABLE		(-9002)

These aren't specific to get-sensor-state.

They're used by at least: ibm,manage-flash-image, ibm,activate-firmware,
ibm,configure-connector, set-indicator etc.

They have different meanings for those calls. I think you're best to
just leave the constant values in rtas_error_rc().

>  /* RTAS event classes */
>  #define RTAS_INTERNAL_ERROR		0x80000000 /* set bit 0 */
>  #define RTAS_EPOW_WARNING		0x40000000 /* set bit 1 */
> @@ -425,6 +432,7 @@ extern int rtas_set_indicator(int indicator, int index, int new_value);
>  extern int rtas_set_indicator_fast(int indicator, int index, int new_value);
>  extern void rtas_progress(char *s, unsigned short hex);
>  int rtas_ibm_suspend_me(int *fw_status);
> +int rtas_generic_errno(int rtas_rc);
>  
>  struct rtc_time;
>  extern time64_t rtas_get_boot_time(void);
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index c087eeee320ff..80b6099e8ce20 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -1330,33 +1330,34 @@ bool __ref rtas_busy_delay(int status)
>  }
>  EXPORT_SYMBOL_GPL(rtas_busy_delay);
>  
> -static int rtas_error_rc(int rtas_rc)
> +int rtas_generic_errno(int rtas_rc)
>  {
>  	int rc;
>  
>  	switch (rtas_rc) {
> -		case -1: 		/* Hardware Error */
> -			rc = -EIO;
> -			break;
> -		case -3:		/* Bad indicator/domain/etc */
> -			rc = -EINVAL;
> -			break;
> -		case -9000:		/* Isolation error */
> -			rc = -EFAULT;
> -			break;
> -		case -9001:		/* Outstanding TCE/PTE */
> -			rc = -EEXIST;
> -			break;
> -		case -9002:		/* No usable slot */
> -			rc = -ENODEV;
> -			break;
> -		default:
> -			pr_err("%s: unexpected error %d\n", __func__, rtas_rc);
> -			rc = -ERANGE;
> -			break;
> +	case RTAS_HARDWARE_ERROR:	/* Hardware Error */
> +		rc = -EIO;
> +		break;
> +	case RTAS_INVALID_PARAMETER:	/* Bad indicator/domain/etc */
> +		rc = -EINVAL;
> +		break;
> +	case RTAS_SLOT_UNISOLATED:	/* Isolation error */
> +		rc = -EFAULT;
> +		break;
> +	case RTAS_SLOT_NOT_UNISOLATED:	/* Outstanding TCE/PTE */
> +		rc = -EEXIST;
> +		break;
> +	case RTAS_SLOT_NOT_USABLE:	/* No usable slot */
> +		rc = -ENODEV;
> +		break;
> +	default:
> +		pr_err("%s: unexpected error %d\n", __func__, rtas_rc);
> +		rc = -ERANGE;
> +		break;
>  	}
>  	return rc;
>  }
> +EXPORT_SYMBOL(rtas_generic_errno);
  
Should be GPL.

cheers
